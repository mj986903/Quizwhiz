namespace QuizWebAPI.Models
{
    public class QuizRequest
    {
        public string QuizTitle { get; set; }
        public string Description { get; set; }
        public string Category { get; set; }
        public int NoOfQuestions { get; set; }
    }
}
