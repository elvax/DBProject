package com.example.view;

import com.example.mysql.MySQLConnector;

import javax.swing.*;
import javax.xml.bind.DatatypeConverter;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class LoginFrame extends JFrame {

    JButton loginButton;
    JPanel loginPanel;
    JTextField userText;
    JTextField passwordText;
    JLabel usernameLabel;
    JLabel passwordLabel;

    MessageDigest md;

    private int studentID;
    private int teacherID;

    private MySQLConnector mySQLConnector;
    private Frame frame;


    public LoginFrame(MySQLConnector mySQLConnector) {
        super("Login");

        this.mySQLConnector = mySQLConnector;

        try {
            md = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        loginButton = new JButton("Login");
        loginPanel = new JPanel();
        userText = new JTextField(15);
        passwordText = new JPasswordField(15);
        usernameLabel = new JLabel("Username - ");
        passwordLabel = new JLabel("Password - ");

        setSize(300, 200);
        setLocation(500, 280);
        loginPanel.setLayout(null);


        userText.setBounds(95, 30, 150, 20);
        passwordText.setBounds(95, 65, 150, 20);
        loginButton.setBounds(110, 100, 80, 20);
        usernameLabel.setBounds(5, 28, 100, 20);
        passwordLabel.setBounds(5, 63, 100, 20);

        loginPanel.add(loginButton);
        loginPanel.add(userText);
        loginPanel.add(passwordText);
        loginPanel.add(usernameLabel);
        loginPanel.add(passwordLabel);

        getContentPane().add(loginPanel);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);

        loginButton.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                whenLoginButtonClicked();
            }
        });

    }

    /**
     * sends given username and hashed password to DB. If correct recieves back id of student
     * and starts Frame
     */
    private void whenLoginButtonClicked() {

        String givenUserName = userText.getText();
        String givenPassword = passwordText.getText();

        String hashPassword = getHash(givenPassword);

        //Sprawdzić czy się zgadza z bazą
        String idString = mySQLConnector.loginStudent(givenUserName, hashPassword);
        if (idString != null) {
            studentID = Integer.parseInt(idString);
            this.setVisible(false);
            frame = new Frame(this.mySQLConnector, studentID);
        } else if (givenUserName.equals("") || givenPassword.equals("")) {
            JOptionPane.showMessageDialog(null, "Please insert Username and Password");
        } else {
            JOptionPane.showMessageDialog(null, "Wrong Username / Password");
            userText.setText("");
            passwordText.setText("");
            userText.requestFocus();
        }
    }

    private String getHash(String pass) {
        md.update(pass.getBytes());
        byte[] digest = md.digest();
        String hashedPassword = DatatypeConverter
                .printHexBinary(digest).toUpperCase();
        return hashedPassword;
    }
}

