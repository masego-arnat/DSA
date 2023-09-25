import ballerina/io;
import ballerina/grpc;

// Define the gRPC client endpoint targeting the "Library" service on localhost:9090
endpoint grpc:Client libraryClient {
    targetUrl: "grpc://localhost:9090",
    secureSocket: {
        // Configure security options if needed
    }
};

// Define the main function
public function main() returns error? {
    // Create a Book message to add a book
    library:Book bookToAdd = {
        title: "Sample Book",
        author_1: "Author One",
        author_2: "Author Two",
        location: "A1",
        isbn: "1234567890",
        status: true // Assuming the book is available
    };

    // Call the addBook remote function to add a book
    library:Book addedBook = check libraryClient->addBook(bookToAdd);

    // Print the added book's details
    io:println("Added Book:");
    io:println("Title: " + addedBook.title);
    io:println("Author 1: " + addedBook.author_1);
    io:println("Author 2: " + addedBook.author_2);
    io:println("Location: " + addedBook.location);
    io:println("ISBN: " + addedBook.isbn);
    io:println("Status: " + addedBook.status);

    // You can continue calling other remote functions here as needed

    // Return success
    return ();
}
