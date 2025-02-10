document.addEventListener("DOMContentLoaded", async () => {
    const API_URL = "https://localhost:7092";
    const quizTitle = document.getElementById("quiz-title");
    const questionsContainer = document.getElementById("questions");
    const quizScore = document.getElementById("quiz-score");

    const urlParams = new URLSearchParams(window.location.search);
    const quizId = urlParams.get("quizId");

    if (!quizId) {
        alert("No quiz selected!");
        return;
    }

    let currentQuestionIndex = 0;
    let questions = [];
    let userAnswers = {}; // Store user-selected answers

    async function fetchQuizDetails(quizId) {
        try {
            const response = await fetch(`${API_URL}/Quiz/get/${quizId}`);
            if (!response.ok) throw new Error(`Server Error: ${response.statusText}`);

            const quiz = await response.json();
            quizTitle.textContent = quiz.quizTitle;
            questions = quiz.questions || [];

            if (questions.length === 0) {
                questionsContainer.innerHTML = `<p class="error-message">No questions available for this quiz.</p>`;
                return;
            }

            displayQuestion(currentQuestionIndex);
        } catch (err) {
            console.error("Error fetching quiz details:", err);
            questionsContainer.innerHTML = `<p class="error-message">Failed to load quiz. Please try again later.</p>`;
        }
    }

    function displayQuestion(index) {
        questionsContainer.innerHTML = '';

        const question = questions[index];
        if (!question) return;

        const questionElement = document.createElement("div");
        questionElement.classList.add("question");

        const options = [question.option1, question.option2, question.option3, question.option4];

        questionElement.innerHTML = `
            <p><strong>${index + 1}. ${question.questionTitle}</strong></p>
            <div class="options-container">
                ${options.map(option => `
                    <label class="option-label">
                        <input type="radio" name="question-${index}" value="${option}" ${userAnswers[index] === option ? "checked" : ""}>
                        <span>${option}</span>
                    </label>
                `).join('')}
            </div>
        `;

        questionsContainer.appendChild(questionElement);

        const buttonContainer = document.createElement("div");
        buttonContainer.classList.add("button-container");

        const backButton = document.createElement("button");
        backButton.id = "back-btn";
        backButton.classList.add("nav-btn");
        backButton.textContent = "Back";
        backButton.disabled = index === 0;
        buttonContainer.appendChild(backButton);

        const nextButton = document.createElement("button");
        nextButton.id = "next-btn";
        nextButton.classList.add("nav-btn");
        nextButton.textContent = index === questions.length - 1 ? "Submit" : "Next";
        buttonContainer.appendChild(nextButton);

        questionsContainer.appendChild(buttonContainer);

        backButton.addEventListener("click", () => {
            saveSelectedAnswer(index);
            if (currentQuestionIndex > 0) {
                currentQuestionIndex--;
                displayQuestion(currentQuestionIndex);
            }
        });

        nextButton.addEventListener("click", () => {
            saveSelectedAnswer(index);
            if (index === questions.length - 1) {
                submitQuiz();
            } else {
                currentQuestionIndex++;
                displayQuestion(currentQuestionIndex);
            }
        });
    }

    function saveSelectedAnswer(index) {
        const selectedOption = document.querySelector(`input[name="question-${index}"]:checked`);
        if (selectedOption) {
            userAnswers[index] = selectedOption.value;
        }
    }

    async function submitQuiz() {
        saveSelectedAnswer(currentQuestionIndex); // Ensure last answer is saved
    
        // Send only an array of selected answers
        const formattedAnswers = questions.map((q, i) => userAnswers[i] || ""); // Default to empty string if unanswered
    
        console.log("Submitting Answers:", JSON.stringify(formattedAnswers));
    
        try {
            const response = await fetch(`${API_URL}/Quiz/submit/${quizId}`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(formattedAnswers), // Correct format
            });
    
            if (!response.ok) throw new Error(`Server Error: ${await response.text()}`);
    
            const result = await response.json();
            quizScore.textContent = `Your score is: ${result}`;
            quizScore.style.display = "block";
            questionsContainer.innerHTML = ''; // Clear questions after submission
    
        } catch (err) {
            console.error("Error submitting quiz:", err);
        }
    }
    

    fetchQuizDetails(quizId);
});
