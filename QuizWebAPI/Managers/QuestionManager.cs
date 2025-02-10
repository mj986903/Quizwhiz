using Microsoft.EntityFrameworkCore;
using QuizWebAPI.Interfaces;
using QuizWebAPI.Models;

namespace QuizWebAPI.Managers
{
    public class QuestionManager : IQuestionManager
    {
        private readonly QuizapiContext _context;

        public QuestionManager(QuizapiContext context)
        {
            _context = context;
        }

        public async Task<List<Question>> GetAllQuestionsAsync()
        {
            return await _context.Questions.ToListAsync();
        }

        public async Task<List<Question>> GetQuestionsByCategoryAsync(string category)
        {
            return await _context.Questions.Where<Question>(i => i.Category.Equals(category)).ToListAsync();
        }

        public async Task<Question> GetQuestionByIdAsync(int questionId)
        {
            return await _context.Questions.FirstOrDefaultAsync(q => q.QuestionId == questionId);
        }

        public async Task<bool> AddQuestionAsync(Question question)
        {
            await _context.Questions.AddAsync(question);
            int result = await _context.SaveChangesAsync();
            return result > 0;
        }

        public async Task<bool> AddQuestionsInBulkAsync(List<Question> questionList)
        {
            var tasks = new List<Task<bool>>();
            foreach (var question in questionList)
            {
                tasks.Add(AddQuestionAsync(question));
            }
            await Task.WhenAll(tasks);
            return true;
        }

        public async Task<bool> UpdateQuestionAsync(int questionId, Question question)
        {
            var existingQuestion = await _context.Questions.FirstOrDefaultAsync(q => q.QuestionId == questionId);
            if (existingQuestion == null)
            {
                return false;
            }
            existingQuestion.QuestionTitle = question.QuestionTitle;
            existingQuestion.Category = question.Category;
            existingQuestion.Answer = question.Answer;
            existingQuestion.Option1 = question.Option1;
            existingQuestion.Option2 = question.Option2;
            existingQuestion.Option3 = question.Option3;
            existingQuestion.Option4 = question.Option4;
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> DeleteQuestionAsync(int questionId)
        {
            var question = await _context.Questions.FirstOrDefaultAsync(q => q.QuestionId == questionId);
            if (question == null)
            {
                return false;
            }
            _context.Questions.Remove(question);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
