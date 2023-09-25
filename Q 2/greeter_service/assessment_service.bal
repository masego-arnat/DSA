import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);

map<UserRequest> users = {
    "admin": {profile: ADMINISTRATOR, password: "password"},
    "assessor": {profile: ASSESSOR, password: "password"},
    "learner": {profile: LEARNER, password: "password"}
};

type BookRecord record {
    string title;
    string author_1;
    string author_2;
    string location;
    string isbn;
    boolean status;
};

// Simulated database to store book records
map<BookRecord> bookDatabase = {};

int randomResult = 2; // Initialize with the starting value

@grpc:Descriptor {value: HELLOWORLD_DESC}
service "Assessment" on ep {

    remote function login(LoginRequest value) returns LoginResponse|error {

        if (users.hasKey(value.userID)) {
            UserRequest? user = users[value.userID];

            if (user is UserRequest && user.password == value.password) {
                Profiles? profile = user["profile"];
                if (profile is Profiles) {
                    return {success: true, profile: profile};
                }
            }

        }
        return {success: false};
    }
    remote function addBook(Book book) returns CustomResponse {
        string newIsbn = generateUniqueIsbn();
        // CustomResponse sdsd = {message : ""};
        // Create a new book record
        BookRecord newBook = {
            title: book.title,
            author_1: book.author_1,
            author_2: book.author_2,
            location: book.location,
            isbn: newIsbn,
            status: true // Assuming the book is initially available
        };

        // Store the book record in your database or perform any other necessary actions
        bookDatabase[newIsbn] = newBook;

        // Return the ISBN of the newly added book

        return {message: newIsbn};
    }

    remote function listAvailableBooks(ListAvailableBooksRequest value) returns RepeatedBook {

        // Book[] availableBooks = filter(book => book.isAvailable)in allBooks;

        // Filter the list to get only available books
        // Book[] allBooks = {
        //     {title: "Book 1", author_1: "Author 1", author_2: "Author 2", location: "Unam Main Campus", isbn: "B1", status: false},

        // };
        // boolean bookRemoved = false;
        Book[] allBooks = initializeBooks();

        // Book[] lecturers = [
        //     // {title: "Book 1", author_1: "Author 1", author_2: "Author 2", location: "Unam Main Campus", isbn: "B1", status: false},
        //     // {title: "Book 2", author_1: "Author 1", author_2: "Author 2", location: "Unam  Khomadal", isbn: "B2", status: false},
        //     // {title: "Book 3", author_1: "Author 1", author_2: "Author 2", location: "Unam Main Campus", isbn: "B3", status: true},
        //     {
        //         title: "Book 4",
        //         author_1: "Author 1",
        //         author_2: "Author 2",
        //         location: "Unam Main Campus",
        //         isbn: "ISBN-3",
        //         status: true
        //     }
        // ];

        // Book[] availablfgeBooks = filter(book => book.status)in allBooks;
        // Book[] availableBooks = filter (value => value.isAvailable) in allBooks;
        // Iterate through the list of books and filter based on availability
        // Create an empty list to store available books
        Book[] availableBooks = [];
        string requestString = value.isbn;
        foreach var book in allBooks {
            if (book.status == true && book.isbn == requestString) {
                availableBooks.push(book);

                // return availableBooks;
            }

        }

        // Create a RepeatedBook record and populate the data field
        RepeatedBook repeatedBook = {data: availableBooks};

        return repeatedBook;

    }

    remote function removeBook(RemoveBookRequest value) returns RemoveBookResponse|error|string {

        string isbnToRemove = value.isbn;
        boolean bookRemoved = false;
        Book[] allBooks = initializeBooks();

        // Initialize a variable of type Book
        Book newBook = {
            title: "New Book Title",
            author_1: "Author 1",
            author_2: "Author 2",
            location: "New Location",
            isbn: "NB1",
            status: true
        };
        // Initialize an array to store books that don't match the ISBN
        // RemoveBookResponse removedBooks = {books :  allBooks} ;
        // RemoveBookResponse repeatdfdedBook = {books: newBook};
        RemoveBookResponse response = {};
        Book[] availableBooks = [];
        string requestString = value.isbn;
        RemoveBookResponse ree = {books: newBook};
        // RemoveBookResponse repeatdfedBook = {books: newBook};
        foreach var book in allBooks {
            if (book.isbn == requestString) {
                ree.books = book;
                // availableBooks.push(book);

                //    repeatdfedBook = {books: book};
                // ree.books.push(book);

                io:println("current book :", book);
                // response.books.push(book);
                bookRemoved = true;
            }

        }

        // Create a RepeatedBook record and populate the data field
        // RemoveBookResponse repeatedBook = {books: availableBooks};

        // foreach int i in 0 ... allBooks.length() - 1 {
        //     //some logic
        //     if (allBooks[i].isbn != isbnToRemove) {
        //         io:println("Book found with  ", allBooks[i]);
        //         newBook = allBooks[i];
        //         repeatdfdedBook.books = allBooks[i];

        //         io:println("Book found with 111 ", repeatdfdedBook.books);
        //         // newBook = allBooks.remove(i);
        //         bookRemoved = true;
        //         // break;
        //     }

        // }

        // Create a RemoveBookResponse record

        // Get the length of the JSON object

        // RemoveBookResponse removedBooks = {books :  allBooks} ;
        // RemoveBookResponse repeatdfedBook = {books: newBook};
        if (bookRemoved) {
            string messadfge = "Book removed successfully";
            // Parse the JSON data into a Ballerina record array
            //  typedesc<json> length = json:sizeOf(ree)

            // io:println(response.books);
            io:println(ree);
            return ree;

        } else {
            string messadfge = "Book Not Found ";
            return messadfge;
        }

    }

    remote function locateBook(LocateBookRequest value) returns LocateBookResponse|error {

        string isbnToSearch = value.isbn;
        Book[] allBooks = initializeBooks();
        string lcolation = "";
        boolean statusom = false;
        // Iterate through the list of books to find a match
        foreach var book in allBooks {
            if (book.isbn == isbnToSearch) {
                if (book.status) {
                    // Book is available, return its location
                    lcolation = book.location;
                    statusom = book.status;
                    return {location: book.location, available: book.status};
                } else {
                    lcolation = book.location;
                    statusom = book.status;
                    // Book is not available "Book is not available at the moment."
                    return {location: book.location, available: false};
                }
            }
        }

        // Book with the specified ISBN was not found
        return {location: lcolation, available: statusom};

    }

    remote function borrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
        string userId = value.userId;
        string isbnToBorrow = value.isbn;
        Book[] allBooks = initializeBooks();
        // Initialize the response with default values
        BorrowBookResponse response = {status: false};
        // Iterate through the list of books to find a match
        foreach var book in allBooks {
            if (book.isbn == isbnToBorrow) {
                if (book.status == true) {
                    response.status = book.status;

                    // Book is available, mark it as borrowed
                    book.status = false;
                    io:println("User ", userId, "Has the Book");
                    return {status: response.status};

                } else {

                    io:println("Book Unavalable ");
                    // Book is not available "Book is not available for borrowing."
                    return {status: false};
                }
            }
        }

        // Book with the specified ISBN was not found
        // return {success: false, message: "Book not found."};
        return response;
    }

    remote function create_user(stream<UserRequest, grpc:Error?> clientStream) returns CreateUserResponse|error {

        CreateUserData[] result = [];

        check clientStream.forEach(function(UserRequest value) {
            if (users.hasKey(value.userCode)) {
                // user already exists
                result.push({userCode: value.userCode, status: "Failed, already exists"});
            } else {
                value.password = "password";
                users[value.userCode] = value;
                result.push({userCode: value.userCode, status: "Created"});
            }
        });

        return {data: result};

    }

}

// Initialize the list of books
function initializeBooks() returns Book[] {
    return [
        {title: "Book 1", author_1: "Author 1", author_2: "Author 2", location: "Unam Main Campus", isbn: "B1", status: false},
        {title: "Book 2", author_1: "Author 1", author_2: "Author 2", location: "Unam  Khomadal", isbn: "B2", status: true},
        {title: "Book 3", author_1: "Author 1", author_2: "Author 2", location: "Unam Main Campus", isbn: "B3", status: true},
        {title: "Book 4", author_1: "Author 1", author_2: "Author 2", location: "Unam Main Campus", isbn: "ISBN-3", status: true}

    ];
}

function generateUniqueIsbn() returns string {
    randomResult = randomResult + 1;

    // int randomInteger =  random:createIntInRange(1, 100);
    return "ISBN-" + randomResult.toString();
}
