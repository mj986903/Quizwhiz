document.addEventListener("DOMContentLoaded", () => {
    const questionsList = document.getElementById("questions-list");
    const filterInput = document.getElementById("filter-category"); // Text input for category filter
    const searchBtn = document.getElementById("search-btn");
    const addQuestionBtn = document.getElementById("add-question-btn");

    const API_URL = "https://localhost:7092"; // Replace with your actual API URL

    // Function to fetch and display all questions (filtered by category if provided)
    function fetchQuestions() {
        let url = `${API_URL}/Question/getAll`;

        fetch(url)
            .then(response => response.json())
            .then(data => {
                displayQuestions(data);
            })
            .catch(error => console.error("Error fetching questions:", error));
    }

    function fetchQuestionsByCatgory(category){
        let url = `${API_URL}/Question/getAllByCategory/${category}`;

        fetch(url)
            .then(response => response.json())
            .then(data => {
                displayQuestions(data);
            })
            .catch(error => console.error("Error fetching questions:", error));
    }

    // Function to render questions
    function displayQuestions(questions) {
        questionsList.innerHTML = ""; // Clear previous results
    
        // Check if no questions are returned
        if (!questions || questions.length === 0) {
            questionsList.innerHTML = "<p class='no-questions'>No questions available.</p>";
            return;
        }
    
        questions.forEach(question => {
            const questionItem = document.createElement("li");
            questionItem.classList.add("question-item");
    
            // Short preview of the question
            const questionPreview = document.createElement("div");
            questionPreview.classList.add("question-preview");
            questionPreview.innerHTML = `<strong>Q:</strong> ${question.questionTitle}`;
    
            // Full details hidden initially
            const questionDetails = document.createElement("div");
            questionDetails.classList.add("question-details", "hidden");
    
            const options = [question.option1, question.option2, question.option3, question.option4]
                .filter(opt => opt)
                .map(opt => `<li>${opt}</li>`)
                .join("");
    
            questionDetails.innerHTML = `
                <p><strong>Category:</strong> ${question.category}</p>
                <ul>${options}</ul>
                <p class="correct-answer"><strong>Answer:</strong> ${question.answer}</p>
            `;
    
            // Toggle details when clicking on a question
            questionPreview.addEventListener("click", () => {
                document.querySelectorAll(".question-details").forEach(detail => {
                    if (detail !== questionDetails) {
                        detail.classList.add("hidden");
                    }
                });
    
                questionDetails.classList.toggle("hidden");
            });
    
            // Append elements to list item
            questionItem.appendChild(questionPreview);
            questionItem.appendChild(questionDetails);
    
            // Append question to the list
            questionsList.appendChild(questionItem);
        });
    }    

    document.getElementById("search-btn").addEventListener("click", () => {
        const category = document.getElementById("filter-category").value.trim();
        if(category === ""){
            fetchQuestions();
        }
        console.log(category);
        fetchQuestionsByCatgory(category); // Call API with filtered category
    });

    // Redirect to Add Question Page
    addQuestionBtn.addEventListener("click", () => {
        window.location.href = "add-question.html";
    });

    // Load all questions when the page loads
    fetchQuestions();
});


