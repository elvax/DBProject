package com.example.view;

import com.example.mysql.MySQLConnector;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class PanelTeacher extends JPanel {
    private MySQLConnector mySQLConnector;
    private int teacherID;

    JButton showMyClassesB;

    JTextArea textArea;
    JScrollPane scrollPane;

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

        textArea = new JTextArea(20, 60);
        scrollPane = new JScrollPane(textArea);

        add(showMyClassesB, "North");
        add(scrollPane, "South");
    }

    private void whenShowMyClassesB() {

    }
}
