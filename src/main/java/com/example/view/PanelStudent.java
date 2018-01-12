package com.example.view;

import com.example.mysql.MySQLConnector;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class PanelStudent extends JPanel {

    private MySQLConnector mySQLConnector;
    private int studentID;

    private JTextArea messageArea;
    private JTextArea myClassesTextArea;
    private JScrollPane scrollPane1;
    private JScrollPane scrollPane2;
    private JButton joinButton;
    private JButton showMyClassesButton;
    private JButton showAvilableClassesB;
    private JLabel giveIdLabel;
    private JLabel welcomeLabel;

    public PanelStudent(MySQLConnector mySQLConnector, int studentID) {
        this.studentID = studentID;
        this.mySQLConnector = mySQLConnector;
        intialize();
        setBackground(Color.DARK_GRAY);
    }

    private void intialize() {
        showMyClassesButton = new JButton("Pokaz moje kursy");
        showMyClassesButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                whenShowMyClassesButtonClicked();
            }
        });

        myClassesTextArea = new JTextArea(20, 65);
        scrollPane2 = new JScrollPane(myClassesTextArea);

        giveIdLabel = new JLabel();
        giveIdLabel.setForeground(Color.WHITE);
        giveIdLabel.setText("Podaj id kursu");

        joinButton = new JButton("Zapisz mnie");
        joinButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                whenJoinButtonClicked();
            }
        });


        welcomeLabel = new JLabel();
        welcomeLabel.setForeground(Color.WHITE);
        welcomeLabel.setText("Witaj " + mySQLConnector.getStudentName(Integer.toString(studentID)));

        showAvilableClassesB = new JButton("pokaz dostepne kursy");
        showAvilableClassesB.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                whenshowAvilableClassesBClicked();
            }
        });

        messageArea = new JTextArea(20, 65);
        scrollPane1 = new JScrollPane(messageArea);

        add(welcomeLabel, "North");
        add(showAvilableClassesB, "North");
        add(scrollPane1, "Center");
        add(showMyClassesButton,"Center");
        add(scrollPane2, "Center");
        add(giveIdLabel, "South");
        add(joinButton, "South");
    }

    private void whenshowAvilableClassesBClicked(){
        try {
            messageArea.setText("");
            messageArea.append(mySQLConnector.writeAvailableCourses());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void whenJoinButtonClicked() {
        String userInput = getUserInput("Podaj id zajec");
        if(userInput != null)
            mySQLConnector.joinStudent(userInput, Integer.toString(studentID));
    }

    private void whenShowMyClassesButtonClicked() {
        myClassesTextArea.setText("");
        myClassesTextArea.append(mySQLConnector.showStudentClasses(Integer.toString(studentID)));
    }

    private String getUserInput(String msg) {
        return JOptionPane.showInputDialog(msg);
    }
}
