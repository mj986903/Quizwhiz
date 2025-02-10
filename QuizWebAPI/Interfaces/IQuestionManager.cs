using QuizWebAPI.Models;

namespace QuizWebAPI.Interfaces
{
    public interface IQuestionManager
    {
        Task<List<Question>> GetAllQuestionsAsync();
        Task<List<Question>> GetQuestionsByCategoryAsync(string category);
        Task<Question> GetQuestionByIdAsync(int questionId);
        Task<bool> AddQuestionAsync(Question question);
        Task<bool> AddQuestionsInBulkAsync(List<Question> questionList);
        Task<bool> UpdateQuestionAsync(int questionId, Question question);
        Task<bool> DeleteQuestionAsync(int questionId);
    }
}
