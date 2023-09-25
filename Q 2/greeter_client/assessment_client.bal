import ballerina/io;

AssessmentClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    LoginRequest loginRequest = {userID: "admin", password: "password"};
    LoginResponse loginResponse = check ep->login(loginRequest);
    io:println(loginResponse);

    Book addBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", isbn: "ballerina", status: true};
    CustomResponse addBookResponse = check ep->addBook(addBookRequest);
    io:println(addBookResponse);

    ListAvailableBooksRequest listAvailableBooksRequest = {isbn: "ISBN-3"};
    RepeatedBook listAvailableBooksResponse = check ep->listAvailableBooks(listAvailableBooksRequest);
    io:println(listAvailableBooksResponse);

    RemoveBookRequest removeBookRequest = {isbn: "ISBN-3"};
    RemoveBookResponse removeBookResponse = check ep->removeBook(removeBookRequest);
        io:println( "dfgdfg zdf");
    io:println(removeBookResponse);
 

    LocateBookRequest locateBookRequest = {isbn: "ISBN-3"};
    LocateBookResponse locateBookResponse = check ep->locateBook(locateBookRequest);
    io:println(locateBookResponse);

    BorrowBookRequest borrowBookRequest = {userId: "ballerina", isbn: "ISfBN-3"};
    BorrowBookResponse borrowBookResponse = check ep->borrowBook(borrowBookRequest);
    io:println(borrowBookResponse);

    UserRequest create_userRequest = {userCode: "ballerina", name: "ballerina", profile: "LEARNER", password: "ballerina"};
    Create_userStreamingClient create_userStreamingClient = check ep->create_user();
    check create_userStreamingClient->sendUserRequest(create_userRequest);
    check create_userStreamingClient->complete();
    CreateUserResponse? create_userResponse = check create_userStreamingClient->receiveCreateUserResponse();
    io:println(create_userResponse);
}

