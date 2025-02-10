using Microsoft.AspNetCore.Mvc;
using QuizWebAPI.Interfaces;
using QuizWebAPI.Models;

namespace QuizWebAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class QuizController : ControllerBase
    {
        private readonly IQuizManager _quizManager;
        public QuizController(IQuizManager quizManager)
        {
            _quizManager = quizManager;
        }

        [HttpGet("getAll", Name = "GetAllQuizzes")]
        public async Task<IActionResult> GetAllQuiz()
        {
            try
            {
                List<QuizWrapper> quizzes = await _quizManager.GetAllQuizzesAsync();
                return Ok(quizzes);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("getByCategory/{category}", Name = "GetAllQuizByCatgory")]
        public async Task<IActionResult> GetAllQuizByCatgory(string category)
        {
            try
            {
                List<QuizWrapper> quizzes = await _quizManager.GetAllQuizzesByCategoryAsync(category);
                return Ok(quizzes);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("create", Name = "CreateQuiz")]
        public async Task<IActionResult> CreateQuiz([FromBody] QuizRequest quizRequest)
        {
            try
            {
                Quiz quiz = await _quizManager.CreateQuizAsync(quizRequest);
                if (quiz != null)
                {
                    return Ok($"Quiz Created Successfully.\nYour Quiz Id: {quiz.QuizId}");
                }
                return NotFound($"{quizRequest.NoOfQuestions} Questions Not Available In Category {quizRequest.Category}.");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("get/{quizId}", Name = "GetQuiz")]
        public async Task<IActionResult> GetQuiz(int quizId)
        {
            try
            {
                QuizResponse quizResponse = await _quizManager.GetQuizAsync(quizId);
                if (quizResponse == null)
                {
                    return NotFound("Quiz Not Found.");
                }
                return Ok(quizResponse);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("submit/{quizId}", Name = "SubmitQuiz")]
        public async Task<IActionResult> SubmitQuiz(int quizId, [FromBody] List<string> responses)
        {
            try
            {
                int result = await _quizManager.SubmitQuizAsync(quizId, responses);
                return Ok(result);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("delete/{quizId}", Name = "DeleteQuiz")]
        public async Task<IActionResult> DeleteQuiz(int quizId)
        {
            try
            {
                bool isDeleted = await _quizManager.DeleteQuizAsync(quizId);
                if (!isDeleted)
                {
                    return NotFound("Quiz Not Found.");
                }
                return Ok("Quiz Deleted Successfully.");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }

}
