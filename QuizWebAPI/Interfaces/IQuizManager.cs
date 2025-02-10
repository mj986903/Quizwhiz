using QuizWebAPI.Models;

namespace QuizWebAPI.Interfaces
{
    public interface IQuizManager
    {
        Task<List<QuizWrapper>> GetAllQuizzesAsync();
        Task<List<QuizWrapper>> GetAllQuizzesByCategoryAsync(string category);
        Task<Quiz> CreateQuizAsync(QuizRequest quizRequest);
        Task<QuizResponse> GetQuizAsync(int quizId);
        Task<bool> DeleteQuizAsync(int quizId);
        Task<int> SubmitQuizAsync(int quizId, List<string> responses);
    }
}
