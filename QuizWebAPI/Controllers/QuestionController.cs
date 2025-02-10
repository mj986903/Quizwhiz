using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using QuizWebAPI.Interfaces;
using QuizWebAPI.Models;

namespace QuizWebAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class QuestionController : ControllerBase
    {
        private readonly IQuestionManager _questionManager;

        public QuestionController(IQuestionManager questionManager)
        {
            _questionManager = questionManager;
        }

        [HttpGet("getAll", Name = "GetAllQuestions")]
        public async Task<IActionResult> GetAllQuestions()
        {
            try
            {
                List<Question> questions = await _questionManager.GetAllQuestionsAsync();
                if (questions.Count == 0)
                {
                    return NotFound("Questions Not Found.");
                }
                return Ok(questions);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("getById/{questionId}", Name = "GetQuestionById")]
        public async Task<IActionResult> GetQuestionsById([FromRoute] int questionId)
        {
            try
            {
                Question question = await _questionManager.GetQuestionByIdAsync(questionId);
                if (question == null)
                {
                    return NotFound("Question With Id " + questionId + " Is Not Found.");
                }
                return Ok(question);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpGet("getAllByCategory/{category}", Name = "GetQuestionsByCategory")]
        public async Task<IActionResult> GetQuestionsByCategory([FromRoute] string category)
        {
            try
            {
                List<Question> questions = await _questionManager.GetQuestionsByCategoryAsync(category);
                return Ok(questions);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        
        [HttpPost("add", Name = "AddQuestion")]
        public async Task<IActionResult> AddQuestion([FromBody] Question question)
        {
            try
            {
                if (string.IsNullOrEmpty(question.QuestionTitle))
                {
                    return ValidationProblem("Enter Question Title.");
                }
                if (string.IsNullOrEmpty(question.Category))
                {
                    return ValidationProblem("Enter Question Category.");
                }
                bool flag = await _questionManager.AddQuestionAsync(question);
                if (flag)
                {
                    return Ok("Question Added Successfully.");
                }
                else
                {
                    return Ok("Question Already Added.");
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("addInBulk", Name = "AddQuestionsInBulk")]
        public async Task<IActionResult> AddQuestionsInBulk([FromBody] List<Question> questions)
        {
            try
            {
                bool flag = await _questionManager.AddQuestionsInBulkAsync(questions);
                if (flag)
                {
                    return Ok("Questions Added Successfully.");
                }
                else
                {
                    return BadRequest("Questions Not Added.");
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpPost("update/{questionId}", Name = "UpdateQuestion")]
        public async Task<IActionResult> UpdateQuestion([FromRoute] int questionId, [FromBody] Question question)
        {
            try
            {
                bool flag = await _questionManager.UpdateQuestionAsync(questionId, question);
                if (flag)
                {
                    return Ok();
                }
                else
                {
                    return NotFound();
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        [HttpDelete("delete/{questionId}", Name = "DeleteQuestion")]
        public async Task<IActionResult> DeleteQuestion(int questionId)
        {
            try
            {
                bool flag = await _questionManager.DeleteQuestionAsync(questionId);
                if (flag)
                {
                    return Ok("Question Deleted Successfully.");
                }
                return NotFound("Question Not Found");
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }

}
