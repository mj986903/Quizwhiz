using Microsoft.EntityFrameworkCore;
using QuizWebAPI.Interfaces;
using QuizWebAPI.Models;

namespace QuizWebAPI.Managers
{
    public class QuizManager : IQuizManager
    {

        private readonly QuizapiContext _context;

        public QuizManager(QuizapiContext context)
        {
            _context = context;
        }

        public async Task<List<QuizWrapper>> GetAllQuizzesAsync()
        {
            List<Quiz> quizzes = await _context.Quizzes.Include(q => q.Questions).ToListAsync(); ;
            List<QuizWrapper> quizWrappers = new List<QuizWrapper>();

            foreach (var quiz in quizzes)
            {
                QuizWrapper quizWrapper = new QuizWrapper();
                quizWrapper.QuizId = quiz.QuizId;
                quizWrapper.QuizTitle = quiz.QuizTitle;
                quizWrapper.Category = quiz.Category;
                quizWrapper.Description = quiz.Description;
                quizWrapper.NoOfQuestions = quiz.Questions.Count;
                quizWrappers.Add(quizWrapper);
            }
            return quizWrappers;
        }

        public async Task<List<QuizWrapper>> GetAllQuizzesByCategoryAsync(string category)
        {
            List<Quiz> quizzes = await _context.Quizzes.Include(q => q.Questions).ToListAsync(); ;
            List<QuizWrapper> quizWrappers = new List<QuizWrapper>();

            foreach (var quiz in quizzes)
            {
                if (quiz.Category.Equals(category, StringComparison.OrdinalIgnoreCase))
                {
                    QuizWrapper quizWrapper = new QuizWrapper();
                    quizWrapper.QuizId = quiz.QuizId;
                    quizWrapper.QuizTitle = quiz.QuizTitle;
                    quizWrapper.Category = quiz.Category;
                    quizWrapper.Description = quiz.Description;
                    quizWrapper.NoOfQuestions = quiz.Questions.Count;
                    quizWrappers.Add(quizWrapper);
                }
            }
            return quizWrappers;
        }
        public async Task<Quiz> CreateQuizAsync(QuizRequest quizRequest)
        {
            Quiz quiz = new Quiz();
            List<Question> catgoryQuestions = await _context.Questions.Where<Question>(i => i.Category.Equals(quizRequest.Category)).ToListAsync();
            List<Question> randomQuestions = new List<Question>();
            if (catgoryQuestions.Count >= quizRequest.NoOfQuestions)
            {
                Random random = new Random();
                int minValue = 0;
                int maxValue = catgoryQuestions.Count;
                HashSet<int> visit = new HashSet<int>();
                int randomNumber = random.Next(minValue, maxValue);
                while (quizRequest.NoOfQuestions > 0)
                {
                    if (!visit.Contains(randomNumber))
                    {
                        randomQuestions.Add(catgoryQuestions[randomNumber]);
                        visit.Add(randomNumber);
                        quizRequest.NoOfQuestions--;
                    }
                    else
                    {
                        randomNumber = random.Next(minValue, maxValue);
                    }
                }
                quiz.QuizTitle = quizRequest.QuizTitle;
                quiz.Description = quizRequest.Description;
                quiz.Questions = randomQuestions;
                quiz.Category = quizRequest.Category;

                _context.Quizzes.Add(quiz);
                await _context.SaveChangesAsync();
            }
            return quiz;
        }

        public async Task<QuizResponse> GetQuizAsync(int quizId)
        {
            QuizResponse quizResponse = new QuizResponse();
            var quiz = await _context.Quizzes.Include(q => q.Questions).FirstOrDefaultAsync(i => i.QuizId == quizId);
            if(quiz != null)
            {
                quizResponse.QuizTitle = quiz.QuizTitle;

                List<QuestionWrapper> questionWrappers = new List<QuestionWrapper>();
                foreach (var question in quiz.Questions)
                {
                    QuestionWrapper questionWrapper = new QuestionWrapper();
                    questionWrapper.QuestionTitle = question.QuestionTitle;
                    questionWrapper.Option1 = question.Option1;
                    questionWrapper.Option2 = question.Option2;
                    questionWrapper.Option3 = question.Option3;
                    questionWrapper.Option4 = question.Option4;
                    questionWrappers.Add(questionWrapper);
                }
                quizResponse.Questions = questionWrappers;
            }
            return quizResponse;
        }

        public async Task<bool> DeleteQuizAsync(int quizId)
        {
            Quiz quiz = await _context.Quizzes.FirstOrDefaultAsync(i => i.QuizId == quizId);
            if (quiz == null)
            {
                return false;
            }
            _context.Remove(quiz);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<int> SubmitQuizAsync(int quizId, List<string> responses)
        {
            var quiz = await _context.Quizzes.Include(q => q.Questions).FirstOrDefaultAsync(i => i.QuizId == quizId);
            if (quiz == null)
            {
                return -1;
            }
            List<Question> questions = quiz.Questions.ToList();
            int result = 0;
            for (int i = 0; i < responses.Count && i < questions.Count; i++)
            {
                if (questions[i].Answer.Equals(responses[i], StringComparison.OrdinalIgnoreCase))
                {
                    result++;
                }
            }
            return result;
        }
    }
}
