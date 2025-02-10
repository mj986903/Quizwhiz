using Microsoft.EntityFrameworkCore;
using QuizWebAPI.Interfaces;
using QuizWebAPI.Managers;
using QuizWebAPI.Models;

var builder = WebApplication.CreateBuilder(args);

// Add CORS Policy
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins",
        policy =>
        {
            policy.AllowAnyOrigin()
                  .AllowAnyMethod()
                  .AllowAnyHeader();
        });
});

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<QuizapiContext>();


//builder.Services.AddSingleton<IQuestionManager, QuestionManager>(); -- Gives System.AggregateException

//builder.Services.AddTransient<IQuestionManager,QuestionManager>(); -- Give InvalidOperationException
//A second operation was started on this context instance before a previous operation completed.
//This is usually caused by different threads concurrently using the same instance of DbContext.

builder.Services.AddScoped<IQuestionManager, QuestionManager>();

builder.Services.AddScoped<IQuizManager, QuizManager>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


// Use CORS
app.UseCors("AllowAllOrigins");

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
