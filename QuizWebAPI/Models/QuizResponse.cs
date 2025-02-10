namespace QuizWebAPI.Models
{
    public class QuizResponse
    {
        public string QuizTitle { get; set; }
        public List<QuestionWrapper> Questions { get; set; } = new List<QuestionWrapper>();
    }
}
