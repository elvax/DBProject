package com.example.mysql;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.*;

public class MySQLConnector {
    private Connection connect = null;
    private Statement statement = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

    public MySQLConnector() throws Exception{
    }

    /**
     * Polaczenie z baza danych przez 1 z 3 mozliwych userow
     * @param user  student, teacher lub admin
     * @throws Exception
     */
    public void prepareEverything(String user) throws Exception{
        try {
            File file=null;
            if (user.equals("student")) {
                file = new File("src/main/resources/student.txt");
            } else if (user.equals("teacher")) {
                file = new File("src/main/resources/teacher.txt");
            } else if (user.equals("admin")) {
                file = new File("src/main/resources/admin.txt");
            }
            FileReader fileReader = new FileReader(file);
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            String loginData = bufferedReader.readLine();

            fileReader.close();
            bufferedReader.close();

            connect = DriverManager
                    .getConnection(loginData);

        } catch (Exception e) {
            throw e;
        }
    }

    /**
     * Usuwa studenta z danego kursu
     * @param idClass       id kursu
     * @param idStudent     id studenta
     */
    public void deleteStudentByID(String idClass, String idStudent) {
        try {
            preparedStatement = connect
                    .prepareStatement("DELETE FROM class_student WHERE student_id=? AND class_id=?");

            preparedStatement.setString(1, idStudent);
            preparedStatement.setString(2,idClass);
            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    /**
     * Pokazuje kursy danego teachera
     * @param idTeacher
     * @return
     */
    public String showTeacherClasses(String idTeacher) {
        try {
            preparedStatement = connect
                    .prepareStatement("SELECT * FROM show_available_classes WHERE teacher_id=?");

            preparedStatement.setString(1, idTeacher);
            resultSet = preparedStatement.executeQuery();

            StringBuilder sb = new StringBuilder();
            resultSet.next();
            sb.append(" "+ resultSet.getString("id"));
            sb.append(" "+ resultSet.getString("name"));
            sb.append(" "+ resultSet.getString("start_date"));
            sb.append(" " + resultSet.getString("end_date"));
            sb.append(" " + resultSet.getString("price"));
            sb.append(" " + resultSet.getString("day"));
            sb.append(" " + resultSet.getString("hours"));
            sb.append(" " + resultSet.getString("level"));
            sb.append(" " + resultSet.getString("n") + "/" + resultSet.getString("max_participants"));
            sb.append("\n");

            return sb.toString();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    /**
     * Wybiera kursy na ktore jest zapisany dany student
     * @param idStudent
     * @return
     */
    public String showStudentClasses(String idStudent) {
        try {
            preparedStatement = connect
                    .prepareStatement("SELECT * FROM show_student_classes WHERE student_id=?");

            preparedStatement.setString(1, idStudent);
            resultSet = preparedStatement.executeQuery();

            StringBuilder sb = new StringBuilder();

            while (resultSet.next()) {
                sb.append(" " + resultSet.getString("id"));
                sb.append(" " + resultSet.getString("name"));
                sb.append(" " + resultSet.getString("start_date"));
                sb.append(" " + resultSet.getString("end_date"));
                sb.append(" " + resultSet.getString("price"));
                sb.append(" " + resultSet.getString("first_name") + " " +
                                  resultSet.getString("last_name"));
                sb.append(" " + resultSet.getString("day"));
                sb.append(" " + resultSet.getString("hours"));
                sb.append("\n");
            }

            return sb.toString();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    /**
     * Wybiera studentow zapisanych na dany kurs
     * @param idClass
     * @return
     */
    public String showStudentsInClass(String idClass) {
        try {
            preparedStatement = connect
                    .prepareStatement("SELECT * FROM show_students_in_class WHERE class_id=?");

            preparedStatement.setString(1, idClass);
            resultSet = preparedStatement.executeQuery();

            StringBuilder sb = new StringBuilder();
            while(resultSet.next()) {
                sb.append(" " + resultSet.getString("student_id"));
                sb.append(" " + resultSet.getString("first_name"));
                sb.append(" " + resultSet.getString("last_name"));
                sb.append(" " + resultSet.getString("phone"));
                sb.append("\n");
            }

            return sb.toString();

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    /**
     * Zapisauje danego studenta na dany kurs
     * @param idClass
     * @param idStudent
     */
    public void joinStudent(String idClass, String idStudent) {
        try {
            preparedStatement = connect
                    .prepareStatement("INSERT INTO class_student(class_id, student_id) VALUES (?, ?)");

            preparedStatement.setString(1, idClass);
            preparedStatement.setString(2, idStudent);

            preparedStatement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }

    }

    /**
     * Wybiera imie i nazwisko danego studenta
     * @param id
     * @return
     */
    public String getStudentName(String id) {
        try {
            preparedStatement = connect
                    .prepareStatement("SELECT first_name, last_name FROM student WHERE id=?");

            preparedStatement.setString(1, id);
            resultSet = preparedStatement.executeQuery();

            resultSet.next();
            return resultSet.getString("first_name") + " " + resultSet.getString("last_name");

        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    /**
     * Sprawdza czy w bazie znajduje sie student z danym loginem
     * i zahashowanym haslem
     * @param userName
     * @param pass
     * @return          id tego studenta
     */
    public String loginStudent(String userName, String pass) {
        try {
            preparedStatement = connect
                    .prepareStatement("SELECT student_id, login, password FROM student_account WHERE login=? AND password=?");

            preparedStatement.setString(1, userName);
            preparedStatement.setString(2, pass);
            resultSet = preparedStatement.executeQuery();

            resultSet.next();
            return resultSet.getString("student_id");

        } catch (SQLException e) {
            System.out.println("blad logowania");
        }
        return null;
    }

    /**
     * Sprawdza czy w bazie znajduje sie teacher z danym loginem
     * i zahashowanym haslem
     * @param userName
     * @param pass
     * @return          id tego teachera
     */
    public String loginTeacher(String userName, String pass) {
        try {
            preparedStatement = connect
                    .prepareStatement("SELECT teacher_id, login, password FROM teacher_account WHERE login=? AND password=?");

            preparedStatement.setString(1, userName);
            preparedStatement.setString(2, pass);
            resultSet = preparedStatement.executeQuery();

            resultSet.next();
            return resultSet.getString("teacher_id");

        } catch (SQLException e) {
            System.out.println("blad logowania");
        }
        return null;
    }

    /**
     * Wybiera kursy na ktore mozna sie zapisac
     * @return
     * @throws Exception
     */
    public String writeAvailableCourses() throws Exception{
        statement = connect.createStatement();

        resultSet = statement.executeQuery(" SELECT * FROM show_available_classes");

        StringBuilder sb = new StringBuilder();
        while (resultSet.next()) {
            sb.append(" "+ resultSet.getString("id"));
            sb.append(" "+ resultSet.getString("name"));
            sb.append(" "+ resultSet.getString("start_date"));
            sb.append(" " + resultSet.getString("end_date"));
            sb.append(" " + resultSet.getString("price"));
            sb.append(" " + resultSet.getString("first_name") + " " +
                              resultSet.getString("last_name"));
            sb.append(" " + resultSet.getString("day"));
            sb.append(" " + resultSet.getString("hours"));
            sb.append(" " + resultSet.getString("level"));
            sb.append(" " + resultSet.getString("n") + "/" + resultSet.getString("max_participants"));
            sb.append("\n");
        }
        return sb.toString();
    }

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
