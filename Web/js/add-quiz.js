const API_URL = "https://localhost:7092"; // Change with your actual API URL

document.getElementById("create-quiz-form").addEventListener("submit", async function(event) {
  event.preventDefault();

  const quizData = {
    quizTitle: document.getElementById("quizTitle").value,
    description: document.getElementById("description").value,
    category: document.getElementById("category").value,
    noOfQuestions: parseInt(document.getElementById("noOfQuestions").value, 10)
  };

  try {
    const response = await fetch(`${API_URL}/Quiz/create`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(quizData)
    });

    console.log("Response Status:", response.status);
console.log("Response Text:", await response.text());

    if (!response.ok) {
      throw new Error(`Server Error: ${await response.text()}`);
    }

    document.getElementById("message").textContent = "Quiz created successfully!";

    // Reset form fields
    document.getElementById("create-quiz-form").reset();
  } catch (error) {
    console.error("Error creating quiz:", error);
    document.getElementById("message").textContent = "Error creating quiz!";
    document.getElementById("message").style.color = "red";
  }
});

// ✅ Go Back Button - Redirects to index.html or quiz list
document.getElementById("go-back").addEventListener("click", function() {
    window.location.href = "index.html"; // Change this to the correct page if needed
});