using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace QuizWebAPI.Models;

public partial class QuizapiContext : DbContext
{
    public QuizapiContext()
    {
    }

    public QuizapiContext(DbContextOptions<QuizapiContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Question> Questions { get; set; }

    public virtual DbSet<Quiz> Quizzes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=(localdb)\\MSSQLLocalDB;Database=QUIZAPI;Trusted_Connection=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Question>(entity =>
        {
            entity.HasKey(e => e.QuestionId).HasName("PK__Question__6238D4B28B83930E");

            entity.ToTable("Question");

            entity.Property(e => e.QuestionId).HasColumnName("questionId");
            entity.Property(e => e.Answer)
                .HasMaxLength(1000)
                .HasColumnName("answer");
            entity.Property(e => e.Category)
                .HasMaxLength(100)
                .HasColumnName("category");
            entity.Property(e => e.Option1)
                .HasMaxLength(1000)
                .HasColumnName("option1");
            entity.Property(e => e.Option2)
                .HasMaxLength(1000)
                .HasColumnName("option2");
            entity.Property(e => e.Option3)
                .HasMaxLength(1000)
                .HasColumnName("option3");
            entity.Property(e => e.Option4)
                .HasMaxLength(1000)
                .HasColumnName("option4");
            entity.Property(e => e.QuestionTitle).HasColumnName("questionTitle");
        });

        modelBuilder.Entity<Quiz>(entity =>
        {
            entity.HasKey(e => e.QuizId).HasName("PK__Quiz__CFF54C3D6FBB331A");

            entity.ToTable("Quiz");

            entity.Property(e => e.QuizId).HasColumnName("quizId");
            entity.Property(e => e.Description).HasColumnName("description");
            entity.Property(e => e.QuizTitle).HasColumnName("quizTitle");


            // Remove Many To Many Relation
            //entity.HasMany(d => d.Questions).WithMany(p => p.Quizzes)
            //    .UsingEntity<Dictionary<string, object>>(
            //        "QuizQuestion",
            //        r => r.HasOne<Question>().WithMany()
            //            .HasForeignKey("QuestionId")
            //            .HasConstraintName("FK__QuizQuest__quest__29572725"),
            //        l => l.HasOne<Quiz>().WithMany()
            //            .HasForeignKey("QuizId")
            //            .HasConstraintName("FK__QuizQuest__quizI__286302EC"),
            //        j =>
            //        {
            //            j.HasKey("QuizId", "QuestionId").HasName("PK__QuizQues__F9D6C176E371A32C");
            //            j.ToTable("QuizQuestions");
            //            j.IndexerProperty<int>("QuizId").HasColumnName("quizId");
            //            j.IndexerProperty<int>("QuestionId").HasColumnName("questionId");
            //        });


            // Add For The Extra Table QuizQuestion
            entity.HasMany(q => q.Questions)
                .WithMany()
                .UsingEntity<Dictionary<string, object>>(
                    "QuizQuestions",
                    j => j.HasOne<Question>()
                          .WithMany()
                          .HasForeignKey("QuestionId")
                          .OnDelete(DeleteBehavior.Cascade),
                    j => j.HasOne<Quiz>()
                          .WithMany()
                          .HasForeignKey("QuizId")
                          .OnDelete(DeleteBehavior.Cascade),
                    j =>
                    {
                        j.HasKey("QuizId", "QuestionId");
                        j.ToTable("QuizQuestions");
                    }
                );
        });
                
        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
