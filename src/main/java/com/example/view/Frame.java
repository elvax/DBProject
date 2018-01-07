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
    private final int X_SIZE = 700;
    private final int Y_SIZE = 750;

    private int studentID;
    MySQLConnector mySQLConnector;
    PanelStudent ps;

    public Frame(MySQLConnector mySQLConnector, int id) throws HeadlessException {
        this.mySQLConnector = mySQLConnector;
        this.studentID = id;

        setSize(X_SIZE, Y_SIZE);
        setTitle("School");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setResizable(true);
        setVisible(true);

        ps = new PanelStudent(this.mySQLConnector, this.studentID);
        add(ps);
    }

}
