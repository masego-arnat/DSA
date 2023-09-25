import ballerina/http; // import ballerina/io;
import ballerina/io;

type Lecturer record {|
    readonly int staffNum;
    string faculty;
    string fname;
    int age;
    string course;
    string OfficeNum;
|};

type NewLecturer record {|
    // readonly string staffNum;
    string faculty;
    string fname;
    int age;
    string course;
    string OfficeNum;
|};

type UpdateLecturer record {|
    int staffNum;
    string faculty;
    string fname;
    int age;
    string course;
    string OfficeNum;
|};

// Define a table with multiple keys

type ErrorDetails record {|
    string message;

|};

type UserNotFound record {|
    *http:NotFound;
    ErrorDetails body;
|};

table<Lecturer> key(staffNum) lecturers = table [

    {staffNum: 1, fname: "John", age: 32, OfficeNum: "100", faculty: "Science", course: "Computer Science"},
    {staffNum: 2, fname: "John Doe", age: 32, OfficeNum: "100", faculty: "Science", course: "Computer Science"},
    {staffNum: 3, fname: "John", age: 32, OfficeNum: "140", faculty: "Law", course: "Commercial"},
    {staffNum: 4, fname: "John", age: 32, OfficeNum: "150", faculty: "Law", course: "Customary Law"}

];

isolated service /social\-media on new http:Listener(9090) {
    //social-medi/lecturers
    resource function get lecturer() returns Lecturer[]|error {
        // Lecturer joe = {id: 1, name: "John", age: 48};
        // return [joe];
        return lecturers.toArray();
    }

    resource function get lecturerStuffNumer/[int staffNum]() returns table<Lecturer>|error|UserNotFound {

        table<Lecturer> highPaidEmployees = from Lecturer emp in lecturers
            where emp.staffNum == staffNum
            order by emp.fname
            select emp;

        if (highPaidEmployees.length() == 0) {
            UserNotFound userNotFound = {
                body: {message: "User Not Found"}
            };
            return userNotFound;
        }

        return highPaidEmployees;

    }

    resource function get lecturerOfficeNumer/[string OfficeNum]() returns table<Lecturer>|error|UserNotFound {

        table<Lecturer> highPaidEmployees = from Lecturer emp in lecturers
            where emp.OfficeNum == OfficeNum
            order by emp.fname
            select emp;

        if (highPaidEmployees.length() == 0) {
            UserNotFound userNotFound = {
                body: {message: "User Not Found"}
            };
            return userNotFound;
        }

        return highPaidEmployees;

    }

    resource function get lecturerSamefaculty/[string faculty]() returns table<Lecturer>|error|UserNotFound {

        table<Lecturer> highPaidEmployees = from Lecturer emp in lecturers
            where emp.faculty == faculty
            order by emp.fname
            select emp;

        if (highPaidEmployees.length() == 0) {
            UserNotFound userNotFound = {
                body: {message: "User Not Found"}
            };
            return userNotFound;
        }

        return highPaidEmployees;

    }

    resource function get lecturerSameCourse/[string course]() returns table<Lecturer>|error|UserNotFound {

        table<Lecturer> highPaidEmployees = from Lecturer emp in lecturers
            where emp.course == course
            order by emp.fname
            select emp;

        if (highPaidEmployees.length() == 0) {
            UserNotFound userNotFound = {
                body: {message: "User Not Found"}
            };
            return userNotFound;
        }
        return highPaidEmployees;

    }

    resource function post lecturerAdd(NewLecturer newLecturer) returns http:Created|error {

        lecturers.add({staffNum: lecturers.length() + 1, ...newLecturer});
        return http:CREATED;
    }

    # Description.
    #
    # + updatedLecturer - parameter description
    # + return - return value description
    resource function post lecturerUpdate(UpdateLecturer updatedLecturer) returns http:Created|error|UserNotFound|string {
        table<Lecturer> highPaidEmployees = from Lecturer emp in lecturers
            where emp.staffNum == updatedLecturer.staffNum
            order by emp.fname
            select emp;

        if (highPaidEmployees.length() == 0) {
            UserNotFound userNotFound = {
                body: {message: "User Not Found"}
            };
            return userNotFound;
        }

        // if (highPaidEmployees.length() != 0) {

        lecturers.put({staffNum: updatedLecturer.staffNum, age: updatedLecturer.age, faculty: updatedLecturer.faculty, OfficeNum: updatedLecturer.OfficeNum, course: updatedLecturer.course, fname: updatedLecturer.fname});
        return http:CREATED;

        // }
        // string f = "Funtion To Update ";
        // return f;
    }

    resource function get lecturerDelete/[int staffNum]() returns table<Lecturer>|error|UserNotFound|http:Ok {
     
        table<Lecturer> highPaidEmployees = from Lecturer emp in lecturers
            where emp.staffNum == staffNum
            // try == emp.staffNum
            order by emp.fname
            select emp;

        if (highPaidEmployees.length() == 0) {
            UserNotFound userNotFound = {
                body: {message: "User Not Found"}
            };
            return userNotFound;
        }
        foreach Lecturer emp in highPaidEmployees {
            int KK = emp.staffNum;
            Lecturer remove = lecturers.remove(KK);

 
            io:println("The removed Entry is: ", remove);
 
        }

        return http:OK;

    }

}

