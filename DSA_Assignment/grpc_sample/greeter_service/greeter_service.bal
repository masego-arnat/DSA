import ballerina/grpc;

// Define a configurable port for the gRPC service
configurable int port = 9090;

// Define the gRPC listener
listener grpc:Listener libraryListener = new (port);

// Define the service based on your Protocol Buffer contract
@grpc:Descriptor {
    value: DESCRIPTOR_LIBRARY_DESC
}
service "Library" on libraryListener {

    // Define remote functions for various library operations here
    remote function addBook(library.Book request) returns library.Book {
        // Implement the logic to add a book here
    }

    remote function createUsers(stream library.User users) returns library.UserResponse {
        // Implement the logic to create users here
    }

    remote function updateBook(library.Book request) returns library.Book {
        // Implement the logic to update a book here
    }

    remote function removeBook(library.Book request) returns library.BookListResponse {
        // Implement the logic to remove a book here
    }

    remote function listAvailableBooks(library.Empty request) returns library.BookListResponse {
        // Implement the logic to list available books here
    }

    remote function locateBook(library.Book request) returns library.LocationResponse {
        // Implement the logic to locate a book here
    }

    remote function borrowBook(library.BorrowRequest request) returns library.BorrowResponse {
        // Implement the logic to borrow a book here
    }
}
