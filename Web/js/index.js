document.addEventListener("DOMContentLoaded", () => {
    const API_URL = "https://localhost:7092";  
    const quizList = document.getElementById("quiz-list");
    const searchBtn = document.getElementById("search-btn");
    const addQuizBtn = document.getElementById("add-quiz-btn");

    // Fetch all quizzes from API
    async function fetchQuizzes() {
        let url = `${API_URL}/Quiz/getAll`;

        try {
            const response = await fetch(url);
            const quizzes = await response.json();

            if (!quizzes || quizzes.length === 0) {
                quizList.innerHTML = `<p class="no-quizzes">No quizzes available.</p>`;
                return;
            }

            displayQuizzes(quizzes);
        } catch (err) {
            console.error("Error fetching quizzes:", err);
            quizList.innerHTML = `<p class="error-message">Failed to load quizzes. Please try again later.</p>`;
        }
    }

    // Fetch quizzes by category
    async function fetchQuizzesByCategory(category) {
        let url = `${API_URL}/Quiz/getByCategory/${category}`;

        try {
            const response = await fetch(url);

            if (!response.ok) {
                throw new Error(`API Error: ${response.statusText}`);
            }

            const quizzes = await response.json();

            if (!quizzes || quizzes.length === 0) {
                quizList.innerHTML = `<p class="no-quizzes">No quizzes available for '${category}'.</p>`;
                return;
            }

            displayQuizzes(quizzes);
        } catch (err) {
            console.error("Error fetching quizzes:", err);
            quizList.innerHTML = `<p class="error-message">Failed to load quizzes. Please try again later.</p>`;
        }
    }

    // Display quizzes in the UI
    function displayQuizzes(quizzes) {
        quizList.innerHTML = ""; // Clear previous results
        
        quizzes.forEach(quiz => {
            const quizItem = document.createElement("li");
            quizItem.classList.add("quiz-card"); 

            const quizInfo = document.createElement("div");
            quizInfo.classList.add("quiz-info");
            quizInfo.innerHTML = `
                <h3 class="quiz-title">${quiz.quizTitle}</h3>
                <span class="quiz-category">Category: ${quiz.category}</span>
                <p class="quiz-description">${quiz.description}</p>
                <p class="quiz-questions">Number of Questions: ${quiz.noOfQuestions}</p>
            `;

            const quizAction = document.createElement("div");
            quizAction.classList.add("quiz-action");
            const startButton = document.createElement("button");
            startButton.classList.add("start-quiz");
            startButton.setAttribute("data-id", quiz.quizId);
            startButton.innerText = "Start Quiz";

            startButton.addEventListener("click", (event) => {
                const quizId = event.target.getAttribute("data-id");
                window.location.href = `../HTML/quiz.html?quizId=${quizId}`;
            });

            quizAction.appendChild(startButton);
            quizItem.appendChild(quizInfo);
            quizItem.appendChild(quizAction);
            quizList.appendChild(quizItem);
        });
    }

    // Search quizzes by category
    searchBtn.addEventListener("click", () => {
        const category = document.getElementById("filter-category").value.trim();
        if (category === "") {
            fetchQuizzes();
            return;
        }
        fetchQuizzesByCategory(category);
    });

    // Add quiz button event listener
    if (addQuizBtn) {
        addQuizBtn.addEventListener("click", () => {
            window.location.href = "../HTML/add-quiz.html";
        });
    } else {
        console.error("Error: Add Quiz button not found.");
    }

    // Load quizzes on page load
    fetchQuizzes();
});
