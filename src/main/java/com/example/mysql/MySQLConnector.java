package com.example.mysql;

import java.sql.*;

public class MySQLConnector {
    private Connection connect = null;
    private Statement statement = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

    public void prepareEverything() throws Exception{

        try {
            Class.forName("com.mysql.jdbc.Driver");

            connect = DriverManager
                    .getConnection("jdbc:mysql://localhost/DanceSchool?"
                                           + "user=tester&password=testerpw");
        } catch (Exception e) {
            throw e;
        }
    }

    public String showStudentClasses(String idStudent) {
        try {
            preparedStatement = connect
                    .prepareStatement("SELECT class.id ," +
                                            "name, " +
                                            "start_date, " +
                                            "end_date, " +
                                            "price, " +
                                            "teacher.first_name, " +
                                            "teacher.last_name, " +
                                            "COUNT(cs.id) AS n, " +
                                            "max_participants " +
                                            "FROM class JOIN teacher ON teacher_id = teacher.id " +
                                            "JOIN class_student cs ON class.id = cs.class_id " +
                                            "WHERE cs.student_id=?" +
                                            "GROUP BY class.id;"
                    );

            preparedStatement.setString(1, idStudent);
            resultSet = preparedStatement.executeQuery();

            StringBuilder sb = new StringBuilder();
            resultSet.next();
            sb.append(" "+ resultSet.getString("class.id"));
            sb.append(" "+ resultSet.getString("name"));
            sb.append(" "+ resultSet.getString("start_date"));
            sb.append(" " + resultSet.getString("end_date"));
            sb.append(" " + resultSet.getString("price"));
            sb.append(" " + resultSet.getString("first_name") + " " +
                              resultSet.getString("last_name"));
            sb.append(" " + resultSet.getString("n") + "/" + resultSet.getString("max_participants"));
            sb.append("\n");

        return sb.toString();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void joinStudent(String idStudent, String idClass) {
        try {
            preparedStatement = connect
                    .prepareStatement("INSERT INTO class_student(class_id, student_id) VALUES (?, ?)");

            preparedStatement.setString(1, idClass);
            preparedStatement.setString(2, idStudent);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public String getStudentName(String id) {
        try {
            preparedStatement = connect
                    .prepareStatement("SELECT first_name, last_name FROM student WHERE id=?");

            preparedStatement.setString(1, id);
            resultSet = preparedStatement.executeQuery();

            resultSet.next();
            return resultSet.getString("first_name") + " " + resultSet.getString("last_name");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String loginStudent(String userName, String pass) {

        try {
            preparedStatement = connect
                    .prepareStatement("SELECT student_id, login, password FROM student_account WHERE login=?");

            preparedStatement.setString(1, userName);
            resultSet = preparedStatement.executeQuery();

            resultSet.next();
            return resultSet.getString("student_id");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void showAvaibleCourses() throws Exception {
        statement = connect.createStatement();

        resultSet = statement.executeQuery(" SELECT name, start_date, " +
                                                   "end_date, " +
                                                   "price, " +
                                                   "teacher.first_name, " +
                                                   "teacher.last_name, " +
                                                   "COUNT(cs.id) AS n, " +
                                                   "max_participants " +
                                                   "FROM class JOIN teacher ON teacher_id = teacher.id " +
                                                   "JOIN class_student cs ON class.id = cs.class_id " +
                                                   "GROUP BY class.id;");
        writeAvaibleCourses(resultSet);
    }

    private void writeAvaibleCourses(ResultSet resultSet) throws Exception{
        while (resultSet.next()) {
            System.out.println("name "+ resultSet.getString("name"));
            System.out.println("start "+ resultSet.getString("start_date"));
            System.out.println("end " + resultSet.getString("end_date"));
            System.out.println("price " + resultSet.getString("price"));
            System.out.println("prowadzący " + resultSet.getString("first_name") + " " +
                                       resultSet.getString("last_name"));
            System.out.println("zapisanych " + resultSet.getString("n") + "/" + resultSet.getString("max_participants"));

        }
    }


    public String writeAvailableCourses() throws Exception{
        statement = connect.createStatement();

        resultSet = statement.executeQuery(" SELECT class.id ," +
                                                   "name, " +
                                                   "start_date, " +
                                                   "end_date, " +
                                                   "price, " +
                                                   "teacher.first_name, " +
                                                   "teacher.last_name, " +
                                                   "COUNT(cs.id) AS n, " +
                                                   "max_participants " +
                                                   "FROM class JOIN teacher ON teacher_id = teacher.id " +
                                                   "JOIN class_student cs ON class.id = cs.class_id " +
                                                   "GROUP BY class.id;");

        StringBuilder sb = new StringBuilder();
        while (resultSet.next()) {
            sb.append(" "+ resultSet.getString("class.id"));
            sb.append(" "+ resultSet.getString("name"));
            sb.append(" "+ resultSet.getString("start_date"));
            sb.append(" " + resultSet.getString("end_date"));
            sb.append(" " + resultSet.getString("price"));
            sb.append(" " + resultSet.getString("first_name") + " " +
                              resultSet.getString("last_name"));
            sb.append(" " + resultSet.getString("n") + "/" + resultSet.getString("max_participants"));
            sb.append("\n");
        }
        return sb.toString();
    }

    public void readDanceSchool() throws Exception {

        try {
            Class.forName("com.mysql.jdbc.Driver");

            connect = DriverManager
                    .getConnection("jdbc:mysql://localhost/DanceSchool?"
                                           + "user=tester&password=testerpw");

            // Statements allow to issue SQL queries to the database
            statement = connect.createStatement();
            // Result set get the result of the SQL query
            resultSet = statement
                    .executeQuery("select * from DanceSchool.class INNER JOIN teacher ON class.teacher_id = teacher.id");
            writeClass(resultSet);



        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
    }

    public void readDataBase() throws Exception {
        try {
            // This will load the MySQL driver, each DB has its own driver
            Class.forName("com.mysql.jdbc.Driver");
            // Setup the connection with the DB
            connect = DriverManager
                    .getConnection("jdbc:mysql://localhost/feedback?"
                                           + "user=sqluser&password=sqluserpw");

            // Statements allow to issue SQL queries to the database
            statement = connect.createStatement();
            // Result set get the result of the SQL query
            resultSet = statement
                    .executeQuery("select * from feedback.comments");

            writeResultSet(resultSet);

            // PreparedStatements can use variables and are more efficient
            preparedStatement = connect
                    .prepareStatement("insert into  feedback.comments values (default, ?, ?, ?, ? , ?, ?)");
            // "myuser, webpage, datum, summary, COMMENTS from feedback.comments");
            // Parameters start with 1
            preparedStatement.setString(1, "Test");
            preparedStatement.setString(2, "TestEmail");
            preparedStatement.setString(3, "TestWebpage");
            preparedStatement.setDate(4, new java.sql.Date(2009, 12, 11));
            preparedStatement.setString(5, "TestSummary");
            preparedStatement.setString(6, "TestComment");
            preparedStatement.executeUpdate();

            preparedStatement = connect
                    .prepareStatement("SELECT myuser, webpage, datum, summary, COMMENTS from feedback.comments");
            resultSet = preparedStatement.executeQuery();
            writeResultSet(resultSet);

            // Remove again the insert comment
//            preparedStatement = connect
//                    .prepareStatement("delete from feedback.comments where myuser= ? ; ");
//            preparedStatement.setString(1, "Test");
//            preparedStatement.executeUpdate();

            resultSet = statement
                    .executeQuery("select * from feedback.comments");
            writeMetaData(resultSet);

        } catch (Exception e) {
            throw e;
        } finally {
            close();
        }

    }

    private void writeMetaData(ResultSet resultSet) throws SQLException {
        //  Now get some metadata from the database
        // Result set get the result of the SQL query

        System.out.println("The columns in the table are: ");

        System.out.println("Table: " + resultSet.getMetaData().getTableName(1));
        for  (int i = 1; i<= resultSet.getMetaData().getColumnCount(); i++){
            System.out.println("Column " +i  + " "+ resultSet.getMetaData().getColumnName(i));
        }
    }

    private void writeRs(ResultSet resultSet) throws SQLException {
        while (resultSet.next()) {
            System.out.print(resultSet.getString("id"));
            System.out.print(" ");
            System.out.println(resultSet.getString("sign"));
        }
    }

    private void writeClass(ResultSet resultSet) throws SQLException{
        while (resultSet.next()) {
            System.out.println(resultSet.getString("name"));
            System.out.println(resultSet.getString("start_date"));
            System.out.println(resultSet.getString("end_date"));
            System.out.println(resultSet.getString("price"));
            System.out.println(resultSet.getString("first_name"));
            System.out.println(resultSet.getString("last_name"));

        }
    }

    private void writeResultSet(ResultSet resultSet) throws SQLException {
        // ResultSet is initially before the first data set
        while (resultSet.next()) {
            // It is possible to get the columns via name
            // also possible to get the columns via the column number
            // which starts at 1
            // e.g. resultSet.getSTring(2);
            String user = resultSet.getString("myuser");
            String website = resultSet.getString("webpage");
            String summary = resultSet.getString("summary");
            java.util.Date date = resultSet.getDate("datum");
            String comment = resultSet.getString("comments");
            System.out.println("User: " + user);
            System.out.println("Website: " + website);
            System.out.println("summary: " + summary);
            System.out.println("Date: " + date);
            System.out.println("Comment: " + comment);
        }
    }

    // You need to close the resultSet
    public void close() {
        try {
            if (resultSet != null) {
                resultSet.close();
            }

            if (statement != null) {
                statement.close();
            }

            if (connect != null) {
                connect.close();
            }
        } catch (Exception e) {

        }
    }

}
