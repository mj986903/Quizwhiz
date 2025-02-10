CREATE DATABASE Temp

USE Temp

CREATE TABLE Question(
	questionId INT IDENTITY(1,1) PRIMARY KEY,
	questionTitle NVARCHAR(MAX) NOT NULL,
	category NVARCHAR(100) NOT NULL,
	answer NVARCHAR(1000) NOT NULL,
	option1 NVARCHAR(1000),
	option2 NVARCHAR(1000),
	option3 NVARCHAR(1000),
	option4 NVARCHAR(1000)
)

CREATE TABLE Quiz(
	quizId INT IDENTITY(210201,1) PRIMARY KEY,
	quizTitle NVARCHAR(MAX) NOT NULL,
	description NVARCHAR(MAX),
)

CREATE TABLE QuizQuestions (
    quizId INT,
    questionId INT,
    PRIMARY KEY (quizId, questionId),
    FOREIGN KEY (quizId) REFERENCES Quiz(quizId) ON DELETE CASCADE,
    FOREIGN KEY (questionId) REFERENCES Question(questionId) ON DELETE CASCADE
)

INSERT INTO Question (questionTitle, category, answer, option1, option2, option3, option4) VALUES
('What is the capital of France?', 'Geography', 'Paris', 'Berlin', 'Madrid', 'Paris', 'Rome'),
('Who wrote "Romeo and Juliet"?', 'Literature', 'William Shakespeare', 'Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'),
('What is the largest planet in our solar system?', 'Science', 'Jupiter', 'Earth', 'Mars', 'Jupiter', 'Saturn'),
('What is the boiling point of water?', 'Science', '100°C', '90°C', '100°C', '110°C', '120°C'),
('Who painted the Mona Lisa?', 'Art', 'Leonardo da Vinci', 'Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Claude Monet'),
('What is the chemical symbol for gold?', 'Science', 'Au', 'Ag', 'Pb', 'Au', 'Fe'),
('What is the longest river in the world?', 'Geography', 'Nile', 'Amazon', 'Yangtze', 'Nile', 'Mississippi'),
('Who discovered penicillin?', 'Science', 'Alexander Fleming', 'Marie Curie', 'Louis Pasteur', 'Alexander Fleming', 'Isaac Newton'),
('What is the capital of Japan?', 'Geography', 'Tokyo', 'Seoul', 'Beijing', 'Tokyo', 'Bangkok'),
('What is the square root of 64?', 'Mathematics', '8', '6', '7', '8', '9'),
('Who was the first President of the United States?', 'History', 'George Washington', 'Thomas Jefferson', 'Abraham Lincoln', 'George Washington', 'John Adams'),
('What is the smallest prime number?', 'Mathematics', '2', '1', '3', '2', '5'),
('What is the main ingredient in guacamole?', 'Food', 'Avocado', 'Tomato', 'Onion', 'Avocado', 'Pepper'),
('What is the currency of the United Kingdom?', 'Economics', 'Pound Sterling', 'Dollar', 'Euro', 'Pound Sterling', 'Yen'),
('What is the hardest natural substance on Earth?', 'Science', 'Diamond', 'Gold', 'Iron', 'Diamond', 'Quartz'),
('Who is known as the "Father of Geometry"?', 'Mathematics', 'Euclid', 'Pythagoras', 'Archimedes', 'Euclid', 'Newton'),
('What is the capital of Canada?', 'Geography', 'Ottawa', 'Toronto', 'Vancouver', 'Ottawa', 'Montreal'),
('What is the largest mammal in the world?', 'Science', 'Blue Whale', 'Elephant', 'Giraffe', 'Blue Whale', 'Hippopotamus'),
('What is the main language spoken in Brazil?', 'Language', 'Portuguese', 'Spanish', 'English', 'Portuguese', 'French'),
('What is the freezing point of water?', 'Science', '0°C', '-1°C', '1°C', '0°C', '5°C'),
('Who wrote "1984"?', 'Literature', 'George Orwell', 'Aldous Huxley', 'Ray Bradbury', 'George Orwell', 'F. Scott Fitzgerald'),
('What is the capital of Italy?', 'Geography', 'Rome', 'Venice', 'Florence', 'Rome', 'Milan'),
('What is the largest ocean on Earth?', 'Geography', 'Pacific Ocean', 'Atlantic Ocean', 'Indian Ocean', 'Pacific Ocean', 'Arctic Ocean'),
('What is the chemical symbol for water?', 'Science', 'H2O', 'O2', 'CO2', 'H2O', 'NaCl'),
('Who is the author of "Pride and Prejudice"?', 'Literature', 'Jane Austen', 'Charlotte Brontë', 'Emily Dickinson', 'Jane Austen', 'Mary Shelley'),
('What is the capital of Australia?', 'Geography', 'Canberra', 'Sydney', 'Melbourne', 'Canberra', 'Brisbane'),
('What is the largest continent on Earth?', 'Geography', 'Asia', 'Africa', 'North America', 'Asia', 'Europe'),
('What is the main ingredient in bread?', 'Food', 'Flour', 'Sugar', 'Salt', 'Flour', 'Yeast'),
('What is the speed of light?', 'Science', '299,792 km/s', '150,000 km/s', '300,000 km/s', '299,792 km/s', '400,000 km/s'),
('What is the capital of Egypt?', 'Geography', 'Cairo', 'Alexandria', 'Giza', 'Cairo', 'Luxor'),
('Who invented the telephone?', 'Science', 'Alexander Graham Bell', 'Thomas Edison', 'Nikola Tesla', 'Alexander Graham Bell', 'Guglielmo Marconi'),
('What is the largest desert in the world?', 'Geography', 'Sahara', 'Arabian', 'Gobi', 'Sahara', 'Kalahari'),
('What is the main ingredient in sushi?', 'Food', 'Rice', 'Noodles', 'Fish', 'Rice', 'Seaweed'),
('What is the capital of Germany?', 'Geography', 'Berlin', 'Munich', 'Frankfurt', 'Berlin', 'Hamburg'),
('Who wrote "The Great Gatsby"?', 'Literature', 'F. Scott Fitzgerald', 'Ernest Hemingway', 'Mark Twain', 'F. Scott Fitzgerald', 'John Steinbeck'),
('What is the chemical formula for table salt?', 'Science', 'NaCl', 'KCl', 'CaCl2', 'NaCl', 'MgCl2'),
('What is the capital of Spain?', 'Geography', 'Madrid', 'Barcelona', 'Seville', 'Madrid', 'Valencia'),
('What is the largest organ in the human body?', 'Biology', 'Skin', 'Liver', 'Heart', 'Skin', 'Lungs');

INSERT INTO Quiz (quizTitle, description) VALUES
('General Knowledge Quiz', 'A quiz to test your general knowledge across various topics.'),
('Science and Nature Quiz', 'Explore the wonders of science and nature with this quiz.'),
('History Quiz', 'Test your knowledge of historical events and figures.'),
('Geography Quiz', 'Challenge yourself with questions about countries, capitals, and landmarks.'),
('Literature Quiz', 'Dive into the world of books and authors with this literature quiz.'),
('Mathematics Quiz', 'Solve problems and answer questions related to mathematics.'),
('Pop Culture Quiz', 'Test your knowledge of movies, music, and celebrities.'),
('Food and Drink Quiz', 'Discover your knowledge about cuisines and beverages from around the world.'),
('Sports Quiz', 'Challenge yourself with questions about various sports and athletes.'),
('Technology Quiz', 'Stay updated with the latest in technology and innovations with this quiz.');

INSERT INTO QuizQuestions (quizId, questionId) VALUES
(210201, 1),
(210201, 2),
(210202, 3),
(210202, 4),
(210203, 5),
(210203, 6),
(210204, 7),
(210204, 8),
(210205, 9),
(210205, 10),
(210206, 11),
(210206, 12),
(210207, 13),
(210207, 14),
(210208, 15),
(210208, 16),
(210209, 17),
(210209, 18),
(210210, 19),
(210210, 20);

SELECT * FROM Question;

SELECT * FROM Quiz;

SELECT * FROM QuizQuestions;




TRUNCATE TABLE QuizQuestions;
TRUNCATE TABLE Quiz;
TRUNCATE TABLE Question;

DELETE FROM Quiz;
DELETE FROM Question;





INSERT INTO Question (questionTitle, category, answer, option1, option2, option3, option4) VALUES
('What is the capital of France?', 'Geography', 'Paris', 'Berlin', 'Madrid', 'Paris', 'Rome'),
('Who wrote "Romeo and Juliet"?', 'Literature', 'William Shakespeare', 'Charles Dickens', 'Mark Twain', 'William Shakespeare', 'Jane Austen'),
('What is the largest planet in our solar system?', 'Science', 'Jupiter', 'Earth', 'Mars', 'Jupiter', 'Saturn'),
('What is the boiling point of water?', 'Science', '100°C', '90°C', '100°C', '110°C', '120°C'),
('Who painted the Mona Lisa?', 'Art', 'Leonardo da Vinci', 'Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Claude Monet'),
('What is the chemical symbol for gold?', 'Science', 'Au', 'Ag', 'Pb', 'Au', 'Fe'),
('What is the longest river in the world?', 'Geography', 'Nile', 'Amazon', 'Yangtze', 'Nile', 'Mississippi'),
('Who discovered penicillin?', 'Science', 'Alexander Fleming', 'Marie Curie', 'Louis Pasteur', 'Alexander Fleming', 'Isaac Newton'),
('What is the capital of Japan?', 'Geography', 'Tokyo', 'Seoul', 'Beijing', 'Tokyo', 'Bangkok'),
('What is the square root of 64?', 'Mathematics', '8', '6', '7', '8', '9'),
('Who was the first President of the United States?', 'History', 'George Washington', 'Thomas Jefferson', 'Abraham Lincoln', 'George Washington', 'John Adams'),
('What is the smallest prime number?', 'Mathematics', '2', '1', '3', '2', '5'),
('What is the main ingredient in guacamole?', 'Food', 'Avocado', 'Tomato', 'Onion', 'Avocado', 'Pepper'),
('What is the currency of the United Kingdom?', 'Economics', 'Pound Sterling', 'Dollar', 'Euro', 'Pound Sterling', 'Yen'),
('What is the hardest natural substance on Earth?', 'Science', 'Diamond', 'Gold', 'Iron', 'Diamond', 'Quartz'),
('Who is known as the "Father of Geometry"?', 'Mathematics', 'Euclid', 'Pythagoras', 'Archimedes', 'Euclid', 'Newton'),
('What is the capital of Canada?', 'Geography', 'Ottawa', 'Toronto', 'Vancouver', 'Ottawa', 'Montreal'),
('What is the largest mammal in the world?', 'Science', 'Blue Whale', 'Elephant', 'Giraffe', 'Blue Whale', 'Hippopotamus'),
('What is the main language spoken in Brazil?', 'Language', 'Portuguese', 'Spanish', 'English', 'Portuguese', 'French'),
('What is the freezing point of water?', 'Science', '0°C', '-1°C', '1°C', '0°C', '5°C'),
('Who wrote "1984"?', 'Literature', 'George Orwell', 'Aldous Huxley', 'Ray Bradbury', 'George Orwell', 'F. Scott Fitzgerald'),
('What is the capital of Italy?', 'Geography', 'Rome', 'Venice', 'Florence', 'Rome', 'Milan'),
('What is the largest ocean on Earth?', 'Geography', 'Pacific Ocean', 'Atlantic Ocean', 'Indian Ocean', 'Pacific Ocean', 'Arctic Ocean'),
('What is the chemical symbol for water?', 'Science', 'H2O', 'O2', 'CO2', 'H2O', 'NaCl'),
('Who is the author of "Pride and Prejudice"?', 'Literature', 'Jane Austen', 'Charlotte Brontë', 'Emily Dickinson', 'Jane Austen', 'Mary Shelley'),
('What is the capital of Australia?', 'Geography', 'Canberra', 'Sydney', 'Melbourne', 'Canberra', 'Brisbane'),
('What is the largest continent on Earth?', 'Geography', 'Asia', 'Africa', 'North America', 'Asia', 'Europe'),
('What is the main ingredient in bread?', 'Food', 'Flour', 'Sugar', 'Salt', 'Flour', 'Yeast'),
('What is the speed of light?', 'Science', '299,792 km/s', '150,000 km/s', '300,000 km/s', '299,792 km/s ', '400,000 km/s'),
('Who invented the telephone?', 'Invention', 'Alexander Graham Bell', 'Thomas Edison', 'Nikola Tesla', 'Alexander Graham Bell', 'Guglielmo Marconi'),
('What is the capital of Germany?', 'Geography', 'Berlin', 'Munich', 'Frankfurt', 'Berlin', 'Hamburg'),
('What is the largest desert in the world?', 'Geography', 'Sahara', 'Arabian', 'Gobi', 'Sahara', 'Kalahari'),
('What is the main ingredient in sushi?', 'Food', 'Rice', 'Noodles', 'Fish', 'Rice', 'Seaweed'),
('What is the chemical symbol for silver?', 'Science', 'Ag', 'Au', 'Pb', 'Ag', 'Fe'),
('Who wrote "The Great Gatsby"?', 'Literature', 'F. Scott Fitzgerald', 'Ernest Hemingway', 'Mark Twain', 'F. Scott Fitzgerald', 'John Steinbeck'),
('What is the capital of Spain?', 'Geography', 'Madrid', 'Barcelona', 'Seville', 'Madrid', 'Valencia'),
('What is the largest animal on land?', 'Science', 'Elephant', 'Giraffe', 'Rhino', 'Elephant', 'Hippo'),
('What is the boiling point of water in Fahrenheit?', 'Science', '212°F', '100°F', '150°F', '212°F', '180°F'),
('Who painted the ceiling of the Sistine Chapel?', 'Art', 'Michelangelo', 'Raphael', 'Donatello', 'Michelangelo', 'Caravaggio'),
('What is the capital of Russia?', 'Geography', 'Moscow', 'St. Petersburg', 'Kazan', 'Moscow', 'Novosibirsk'),
('What is the primary gas found in the air we breathe?', 'Science', 'Nitrogen', 'Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen'),
('Who is known as the "King of Pop"?', 'Music', 'Michael Jackson', 'Elvis Presley', 'Prince', 'Michael Jackson', 'Madonna'),
('What is the capital of India?', 'Geography', 'New Delhi', 'Mumbai', 'Kolkata', 'New Delhi', 'Chennai'),
('What is the largest organ in the human body?', 'Biology', 'Skin', 'Liver', 'Heart', 'Skin', 'Lungs'),
('What is the main ingredient in chocolate?', 'Food', 'Cocoa', 'Sugar', 'Milk', 'Cocoa', 'Vanilla'),
('What is the capital of Egypt?', 'Geography', 'Cairo', 'Alexandria', 'Giza', 'Cairo', 'Luxor'),
('What is the chemical symbol for iron?', 'Science', 'Fe', 'Ir', 'I', 'Fe', 'Au'),
('Who wrote "To Kill a Mockingbird"?', 'Literature', 'Harper Lee', 'Mark Twain', 'J.D. Salinger', 'Harper Lee', 'F. Scott Fitzgerald'),
('What is the capital of Mexico?', 'Geography', 'Mexico City', 'Guadalajara', 'Monterrey', 'Mexico City', 'Cancun'),
('What is the largest volcano in the world?', 'Geography', 'Mauna Loa', 'Kilimanjaro', 'Mount St. Helens', 'Mauna Loa', 'Mount Fuji'),
('What is the main ingredient in hummus?', 'Food', 'Chickpeas', 'Lentils', 'Beans', 'Chickpeas', 'Peas'),
('What is the capital of South Africa?', 'Geography', 'Pretoria', 'Cape Town', 'Johannesburg', 'Pretoria', 'Durban'),
('What is the chemical symbol for carbon?', 'Science', 'C', 'Ca', 'Co', 'C', 'Cu'),
('Who is known as the "Queen of Soul"?', 'Music', 'Aretha Franklin', 'Whitney Houston', 'Tina Turner', 'Aretha Franklin', 'Diana Ross'),
('What is the capital of Argentina?', 'Geography', 'Buenos Aires', 'Córdoba', 'Rosario', 'Buenos Aires', 'Mendoza'),
('What is the largest species of shark?', 'Science', 'Whale Shark', 'Great White Shark', 'Tiger Shark', 'Whale Shark', 'Hammerhead Shark'),
('What is the main ingredient in pesto?', 'Food', 'Basil', 'Parsley', 'Cilantro', 'Basil', 'Oregano'),
('What is the capital of Thailand?', 'Geography', 'Bangkok', 'Chiang Mai', 'Phuket', 'Bangkok', 'Pattaya'),
('What is the chemical symbol for sodium?', 'Science', 'Na', 'S', 'K', 'Na', 'Ca'),
('Who wrote "The Catcher in the Rye"?', 'Literature', 'J.D. Salinger', 'F. Scott Fitzgerald', 'Ernest Hemingway', 'J.D. Salinger', 'Mark Twain'),
('What is the capital of Greece?', 'Geography', 'Athens', 'Rome', 'Cairo', 'Athens', 'Istanbul'),
('What is the largest land animal?', 'Science', 'African Elephant', 'Asian Elephant', 'Giraffe', 'African Elephant', 'Hippopotamus'),
('What is the main ingredient in a Caesar salad?', 'Food', 'Romaine lettuce', 'Spinach', 'Kale', 'Romaine lettuce', 'Iceberg lettuce'),
('What is the capital of Sweden?', 'Geography', 'Stockholm', 'Gothenburg', 'Malmo', 'Stockholm', 'Uppsala'),
('What is the chemical symbol for potassium?', 'Science', 'K', 'P', 'Na', 'K', 'Ca'),
('Who wrote "Moby Dick"?', 'Literature', 'Herman Melville', 'Mark Twain', 'Ernest Hemingway', 'Herman Melville', 'F. Scott Fitzgerald'),
('What is the capital of Norway?', 'Geography', 'Oslo', 'Bergen', 'Stavanger', 'Oslo', 'Trondheim'),
('What is the largest species of penguin?', 'Science', 'Emperor Penguin', 'King Penguin', 'Adelie Penguin', 'Emperor Penguin', 'Gentoo Penguin'),
('What is the main ingredient in a traditional Greek tzatziki sauce?', 'Food', 'Yogurt', 'Sour cream', 'Mayonnaise', 'Yogurt', 'Cream cheese'),
('What is the capital of Finland?', 'Geography', 'Helsinki', 'Espoo', 'Tampere', 'Helsinki', 'Oulu'),
('What is the chemical symbol for mercury?', 'Science', 'Hg', 'Mn', 'Mg', 'Hg', 'Fe'),
('Who wrote "The Odyssey"?', 'Literature', 'Homer', 'Virgil', 'Ovid', 'Homer', 'Sophocles'),
('What is the capital of Portugal?', 'Geography', 'Lisbon', 'Porto', 'Braga', 'Lisbon', 'Coimbra'),
('What is the largest species of bear?', 'Science', 'Polar Bear', 'Grizzly Bear', 'Black Bear', 'Polar Bear', 'Kodiak Bear'),
('What is the main ingredient in a traditional lasagna?', 'Food', 'Pasta', 'Rice', 'Bread', 'Pasta', 'Noodles'),
('What is the capital of Belgium?', 'Geography', 'Brussels', 'Antwerp', 'Ghent', 'Brussels', 'Bruges'),
('What is the chemical symbol for lead?', 'Science', 'Pb', 'Li', 'Fe', 'Pb', 'Au'),
('Who wrote "The Picture of Dorian Gray"?', 'Literature', 'Oscar Wilde', 'Charles Dickens', 'George Orwell', 'Oscar Wilde', 'J.K. Rowling'),
('What is the capital of Switzerland?', 'Geography', 'Bern', 'Zurich', 'Geneva', 'Bern', 'Lausanne'),
('What is the largest type of cat?', 'Science', 'Siberian Tiger', 'Lion', 'Cheetah', 'Siberian Tiger', 'Jaguar'),
('What is the main ingredient in a traditional curry?', 'Food', 'Spices', 'Meat', 'Vegetables', 'Spices', 'Rice'),
('What is the capital of Austria?', 'Geography', 'Vienna', 'Salzburg', 'Innsbruck', 'Vienna', 'Graz'),
('What is the chemical symbol for zinc?', 'Science', 'Zn', 'Z', 'Zc', 'Zn', 'Zr'),
('Who wrote "Brave New World"?', 'Literature', 'Aldous Huxley', 'George Orwell', 'Ray Bradbury', 'Aldous Huxley', 'Philip K. Dick'),
('What is the capital of Hungary?', 'Geography', 'Budapest', 'Debrecen', 'Szeged', 'Budapest', 'Miskolc'),
('What is the largest rodent in the world?', 'Science', 'Capybara', 'Beaver', 'Porcupine', 'Capybara', 'Guinea Pig'),
('What is the main ingredient in a traditional paella?', 'Food', 'Rice', 'Pasta', 'Quinoa', 'Rice', 'Barley'),
('What is the capital of Denmark?', 'Geography', 'Copenhagen', 'Aarhus', 'Odense', 'Copenhagen', 'Aalborg'),
('What is the chemical symbol for chlorine?', 'Science', 'Cl', 'C', 'Ca', 'Cl', 'Co'),
('Who wrote ("The Brothers Karamazov"?', 'Literature', 'Fyodor Dostoevsky', 'Leo Tolstoy', 'Anton Chekhov', 'Fyodor Dostoevsky', 'Nikolai Gogol'),
('What is the capital of Iceland?', 'Geography', 'Reykjavik', 'Akureyri', 'Kopavogur', 'Reykjavik', 'Selfoss'),
('What is the largest species of dolphin?', 'Science', 'Orca', 'Bottlenose Dolphin', 'Spinner Dolphin', 'Orca', 'Common Dolphin'),
('What is the main ingredient in a traditional shepherd’s pie?', 'Food', 'Ground meat', 'Chicken', 'Fish', 'Ground meat', 'Vegetables'),
('What is the capital of New Zealand?', 'Geography', 'Wellington', 'Auckland', 'Christchurch', 'Wellington', 'Hamilton'),
('What is the chemical symbol for nitrogen?', 'Science', 'N', 'O', 'C', 'N', 'H'),
('Who wrote "The Grapes of Wrath"?', 'Literature', 'John Steinbeck', 'Ernest Hemingway', 'F. Scott Fitzgerald', 'John Steinbeck', 'Mark Twain'),
('What is the capital of Malaysia?', 'Geography', 'Kuala Lumpur', 'Penang', 'Malacca', 'Kuala Lumpur', 'Johor Bahru'),
('What is the largest land carnivore?', 'Science', 'Polar Bear', 'Grizzly Bear', 'Tiger', 'Polar Bear', 'Wolf'),
('What is the main ingredient in a traditional moussaka?', 'Food', 'Eggplant', 'Potato', 'Zucchini', 'Eggplant', 'Meat');