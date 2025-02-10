namespace QuizWebAPI.Models
{
    public class QuizWrapper
    {
        public int QuizId { get; set; }
        public string QuizTitle { get; set; }
        public string Category { get; set; }
        public string Description { get; set; }
        public int NoOfQuestions { get; set; }
    }
}
