package com.example.view;

import com.example.mysql.MySQLConnector;

import javax.swing.*;
import javax.xml.bind.DatatypeConverter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Frame extends JFrame {
    private final int X_SIZE = 750;
    private final int Y_SIZE = 750;

    private int studentID;
    MySQLConnector mySQLConnector;
    JPanel ps;
    String whichPanel;

    public Frame(MySQLConnector mySQLConnector, int id, String whichPanel) throws HeadlessException {
        this.mySQLConnector = mySQLConnector;
        this.studentID = id;
        this.whichPanel = whichPanel;

        setSize(X_SIZE, Y_SIZE);
        setTitle("School");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setResizable(false);
        setVisible(true);

        if (whichPanel.equals("student")) {
            ps = new PanelStudent(this.mySQLConnector, this.studentID);
        } else if (whichPanel.equals("teacher")) {
            ps = new PanelTeacher(this.mySQLConnector, this.studentID);
        } else if (whichPanel.equals("admin")) {
            ps = new PanelAdmin(this.mySQLConnector);
        }
        add(ps);

    }

}
