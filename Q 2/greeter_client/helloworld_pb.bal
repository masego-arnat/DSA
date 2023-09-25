import ballerina/grpc;
import ballerina/protobuf;

public const string HELLOWORLD_DESC = "0A1068656C6C6F776F726C642E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22310A1252656D6F7665426F6F6B526573706F6E7365121B0A05626F6F6B7318012001280B32052E426F6F6B5205626F6F6B7322270A1152656D6F7665426F6F6B5265717565737412120A046973626E18012001280952046973626E222F0A194C697374417661696C61626C65426F6F6B735265717565737412120A046973626E18012001280952046973626E222C0A12426F72726F77426F6F6B526573706F6E736512160A06737461747573180620012808520673746174757322270A114C6F63617465426F6F6B5265717565737412120A046973626E18012001280952046973626E223F0A11426F72726F77426F6F6B5265717565737412160A06757365724964180120012809520675736572496412120A046973626E18022001280952046973626E224E0A124C6F63617465426F6F6B526573706F6E7365121A0A086C6F636174696F6E18012001280952086C6F636174696F6E121C0A09617661696C61626C651802200128085209617661696C61626C65222A0A0E437573746F6D526573706F6E736512180A076D65737361676518012001280952076D65737361676522790A0F4173736573736F7252657175657374121E0A0A636F75727365436F6465180120012809520A636F75727365436F646512220A0C61737369676E6D656E744944180220012805520C61737369676E6D656E74494412220A0C6173736573736F72436F6465180320012809520C6173736573736F72436F646522420A0C4C6F67696E5265717565737412160A067573657249441801200128095206757365724944121A0A0870617373776F7264180220012809520870617373776F7264224E0A0D4C6F67696E526573706F6E736512180A077375636365737318012001280852077375636365737312230A0770726F66696C6518022001280E32092E50726F66696C6573520770726F66696C65227E0A0B5573657252657175657374121A0A0875736572436F6465180120012809520875736572436F646512120A046E616D6518022001280952046E616D6512230A0770726F66696C6518032001280E32092E50726F66696C6573520770726F66696C65121A0A0870617373776F7264180420012809520870617373776F726422440A0E4372656174655573657244617461121A0A0875736572436F6465180120012809520875736572436F646512160A06737461747573180220012809520673746174757322390A1243726561746555736572526573706F6E736512230A046461746118012003280B320F2E4372656174655573657244617461520464617461229A010A04426F6F6B12140A057469746C6518012001280952057469746C6512190A08617574686F725F311802200128095207617574686F723112190A08617574686F725F321803200128095207617574686F7232121A0A086C6F636174696F6E18042001280952086C6F636174696F6E12120A046973626E18052001280952046973626E12160A06737461747573180620012808520673746174757322290A0C5265706561746564426F6F6B12190A046461746118012003280B32052E426F6F6B5204646174612A380A0850726F66696C6573120B0A074C4541524E4552100012110A0D41444D494E4953545241544F521001120C0A084153534553534F52100232F1020A0A4173736573736D656E7412320A0B6372656174655F75736572120C2E55736572526571756573741A132E43726561746555736572526573706F6E7365280112260A056C6F67696E120D2E4C6F67696E526571756573741A0E2E4C6F67696E526573706F6E736512210A07616464426F6F6B12052E426F6F6B1A0F2E437573746F6D526573706F6E7365123F0A126C697374417661696C61626C65426F6F6B73121A2E4C697374417661696C61626C65426F6F6B73526571756573741A0D2E5265706561746564426F6F6B12350A0A72656D6F7665426F6F6B12122E52656D6F7665426F6F6B526571756573741A132E52656D6F7665426F6F6B526573706F6E736512350A0A6C6F63617465426F6F6B12122E4C6F63617465426F6F6B526571756573741A132E4C6F63617465426F6F6B526573706F6E736512350A0A626F72726F77426F6F6B12122E426F72726F77426F6F6B526571756573741A132E426F72726F77426F6F6B526573706F6E7365620670726F746F33";

public isolated client class AssessmentClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, HELLOWORLD_DESC);
    }

    isolated remote function login(LoginRequest|ContextLoginRequest req) returns LoginResponse|grpc:Error {
        map<string|string[]> headers = {};
        LoginRequest message;
        if req is ContextLoginRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/login", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <LoginResponse>result;
    }

    isolated remote function loginContext(LoginRequest|ContextLoginRequest req) returns ContextLoginResponse|grpc:Error {
        map<string|string[]> headers = {};
        LoginRequest message;
        if req is ContextLoginRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/login", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <LoginResponse>result, headers: respHeaders};
    }

    isolated remote function addBook(Book|ContextBook req) returns CustomResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/addBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CustomResponse>result;
    }

    isolated remote function addBookContext(Book|ContextBook req) returns ContextCustomResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/addBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CustomResponse>result, headers: respHeaders};
    }

    isolated remote function listAvailableBooks(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns RepeatedBook|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/listAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RepeatedBook>result;
    }

    isolated remote function listAvailableBooksContext(ListAvailableBooksRequest|ContextListAvailableBooksRequest req) returns ContextRepeatedBook|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableBooksRequest message;
        if req is ContextListAvailableBooksRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/listAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RepeatedBook>result, headers: respHeaders};
    }

    isolated remote function removeBook(RemoveBookRequest|ContextRemoveBookRequest req) returns RemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveBookResponse>result;
    }

    isolated remote function removeBookContext(RemoveBookRequest|ContextRemoveBookRequest req) returns ContextRemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveBookRequest message;
        if req is ContextRemoveBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveBookResponse>result, headers: respHeaders};
    }

    isolated remote function locateBook(LocateBookRequest|ContextLocateBookRequest req) returns LocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <LocateBookResponse>result;
    }

    isolated remote function locateBookContext(LocateBookRequest|ContextLocateBookRequest req) returns ContextLocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateBookRequest message;
        if req is ContextLocateBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <LocateBookResponse>result, headers: respHeaders};
    }

    isolated remote function borrowBook(BorrowBookRequest|ContextBorrowBookRequest req) returns BorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BorrowBookResponse>result;
    }

    isolated remote function borrowBookContext(BorrowBookRequest|ContextBorrowBookRequest req) returns ContextBorrowBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Assessment/borrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BorrowBookResponse>result, headers: respHeaders};
    }

    isolated remote function create_user() returns Create_userStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("Assessment/create_user");
        return new Create_userStreamingClient(sClient);
    }
}

public client class Create_userStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUserRequest(UserRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUserRequest(ContextUserRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCreateUserResponse() returns CreateUserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <CreateUserResponse>payload;
        }
    }

    isolated remote function receiveContextCreateUserResponse() returns ContextCreateUserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <CreateUserResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public type ContextUserRequestStream record {|
    stream<UserRequest, error?> content;
    map<string|string[]> headers;
|};

public type ContextRepeatedBook record {|
    RepeatedBook content;
    map<string|string[]> headers;
|};

public type ContextLoginResponse record {|
    LoginResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookRequest record {|
    RemoveBookRequest content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookResponse record {|
    BorrowBookResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableBooksRequest record {|
    ListAvailableBooksRequest content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookResponse record {|
    RemoveBookResponse content;
    map<string|string[]> headers;
|};

public type ContextLoginRequest record {|
    LoginRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookRequest record {|
    LocateBookRequest content;
    map<string|string[]> headers;
|};

public type ContextLocateBookResponse record {|
    LocateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    Book content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookRequest record {|
    BorrowBookRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateUserResponse record {|
    CreateUserResponse content;
    map<string|string[]> headers;
|};

public type ContextCustomResponse record {|
    CustomResponse content;
    map<string|string[]> headers;
|};

public type ContextUserRequest record {|
    UserRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type RepeatedBook record {|
    Book[] data = [];
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type LoginResponse record {|
    boolean success = false;
    Profiles profile = LEARNER;
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type RemoveBookRequest record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type BorrowBookResponse record {|
    boolean status = false;
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type ListAvailableBooksRequest record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type RemoveBookResponse record {|
       Book books = {};
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type LoginRequest record {|
    string userID = "";
    string password = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type CreateUserData record {|
    string userCode = "";
    string status = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type LocateBookRequest record {|
    string isbn = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type LocateBookResponse record {|
    string location = "";
    boolean available = false;
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type AssessorRequest record {|
    string courseCode = "";
    int assignmentID = 0;
    string assessorCode = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type Book record {|
    string title = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    string isbn = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type BorrowBookRequest record {|
    string userId = "";
    string isbn = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type CreateUserResponse record {|
    CreateUserData[] data = [];
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type CustomResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: HELLOWORLD_DESC}
public type UserRequest record {|
    string userCode = "";
    string name = "";
    Profiles profile = LEARNER;
    string password = "";
|};

public enum Profiles {
    LEARNER, ADMINISTRATOR, ASSESSOR
}

