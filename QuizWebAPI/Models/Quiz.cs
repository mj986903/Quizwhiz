using System;
using System.Collections.Generic;

namespace QuizWebAPI.Models;

public partial class Quiz
{
    public int QuizId { get; set; }

    public string QuizTitle { get; set; } = null!;

    public string? Description { get; set; }
    public string Category { get; set; }

    public virtual ICollection<Question> Questions { get; set; } = new List<Question>();
}
