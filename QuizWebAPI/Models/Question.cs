using System;
using System.Collections.Generic;

namespace QuizWebAPI.Models;

public partial class Question
{
    public int QuestionId { get; set; }

    public string QuestionTitle { get; set; } = null!;

    public string Category { get; set; } = null!;

    public string Answer { get; set; } = null!;

    public string? Option1 { get; set; }

    public string? Option2 { get; set; }

    public string? Option3 { get; set; }

    public string? Option4 { get; set; }

    // Remove For Avoid Cicular Dependecy
    //public virtual ICollection<Quiz> Quizzes { get; set; } = new List<Quiz>();
}
