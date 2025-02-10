document.addEventListener("DOMContentLoaded", () => {
    const form = document.getElementById("add-question-form");
    const goBackButton = document.getElementById("go-back");
    const API_URL = "https://localhost:7092"; // Replace with your actual API URL

    form.addEventListener("submit", async (event) => {
        event.preventDefault();

        // Collect form data
        const option1 = document.getElementById("option1").value.trim();
        const option2 = document.getElementById("option2").value.trim();
        const option3 = document.getElementById("option3").value.trim();
        const option4 = document.getElementById("option4").value.trim();
        const selectedAnswer = document.getElementById("answer").value.trim();

        // Convert answer option to actual text value
        let answerText = "";
        if (selectedAnswer === "option1") answerText = option1;
        if (selectedAnswer === "option2") answerText = option2;
        if (selectedAnswer === "option3") answerText = option3;
        if (selectedAnswer === "option4") answerText = option4;

        // Validate required fields
        if (!answerText) {
            alert("Select the correct answer.");
            return;
        }

        const questionData = {
            questionTitle: document.getElementById("question-title").value.trim(),
            category: document.getElementById("category").value.trim(),
            option1: option1,
            option2: option2,
            option3: option3,
            option4: option4,
            answer: answerText // Send the actual text, not "option1", "option2", etc.
        };

        try {
            let url = `${API_URL}/Question/add`;

            const response = await fetch(url, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(questionData)
            });
            
            let result;
            const contentType = response.headers.get("content-type");
            
            if (contentType && contentType.includes("application/json")) {
                result = await response.json();
            } else {
                result = await response.text(); // Handle non-JSON response
            }
            
            if (response.ok) {
                alert("Question Added Successfully.");
                form.reset(); // Clear the form
                window.location.href = "questions.html"; // Redirect to Questions page
            } else {
                alert(result || "An error occurred.");
            }
        } catch (error) {
            console.error("Error:", error);
            alert("Failed to add question. Please try again.");
        }
    });

    // Go back button functionality
    goBackButton.addEventListener("click", () => {
        window.history.back();
    });
});
