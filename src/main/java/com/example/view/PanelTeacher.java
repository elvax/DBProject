package com.example.view;

import com.example.mysql.MySQLConnector;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class PanelTeacher extends JPanel {
    private MySQLConnector mySQLConnector;
    private int teacherID;
    private String classID;

    private JButton showMyClassesB;
    private JButton showMyStudentsB;
    private JButton deleteStudentB;
    private JTextArea messageArea1;
    private JTextArea messageArea2;
    private JScrollPane scrollPane1;
    private JScrollPane scrollPane2;

    private JTextArea textArea;
    private JScrollPane scrollPane;

    public PanelTeacher(MySQLConnector mySQLConnector, int teacherID) {
        this.mySQLConnector = mySQLConnector;
        this.teacherID = teacherID;
        setBackground(Color.DARK_GRAY);
        intitializeButtons();
    }
    private void intitializeButtons() {
        showMyClassesB = new JButton("show my classes");
        showMyClassesB.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                whenShowMyClassesB();
            }
        });

        messageArea1 = new JTextArea(20, 60);
        scrollPane1 = new JScrollPane(messageArea1);

        showMyStudentsB = new JButton("show my students");
        showMyStudentsB.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                whenShowMyStudentsB();
            }
        });
        messageArea2 = new JTextArea(20, 60);
        scrollPane2 = new JScrollPane(messageArea2);

        deleteStudentB = new JButton("delete student by id");
        deleteStudentB.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                whenDeleteStudentB();
            }
        });

        textArea = new JTextArea(20, 60);
        scrollPane = new JScrollPane(textArea);

        add(showMyClassesB, "North");
        add(scrollPane1, "Center");
        add(showMyStudentsB,"Center");
        add(scrollPane2, "Center");
        add(deleteStudentB, "South");

    }

    private void whenShowMyClassesB() {
        messageArea1.setText("id name start end price prowadzacy miejsca\n");
        messageArea1.append(mySQLConnector.showTeacherClasses(Integer.toString(teacherID)));
    }

    private void whenShowMyStudentsB() {
        classID = getUserInput("podaj id kursu");
        messageArea2.setText("id name last_name phone\n");
        messageArea2.append(mySQLConnector.showStudentsInClass(classID));
    }

    private void whenDeleteStudentB() {
        String id = getUserInput("podaj id studenta");
        mySQLConnector.deleteStudentByID(classID, id);
    }

    private String getUserInput(String msg) {
        return JOptionPane.showInputDialog(msg);
    }


}
