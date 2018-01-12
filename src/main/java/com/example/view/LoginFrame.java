package com.example.view;

import com.example.mysql.MySQLConnector;

import javax.swing.*;
import javax.xml.bind.DatatypeConverter;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Okno służące do logowania
 */
public class LoginFrame extends JFrame{

    private JButton loginButton;
    private JPanel loginPanel;
    private JTextField userText;
    private JTextField passwordText;
    private JLabel usernameLabel;
    private JLabel passwordLabel;

    private MessageDigest md;

    private int ID;

    private String whichPanel;

    private MySQLConnector mySQLConnector;
    private Frame frame;



    public LoginFrame() {
        super("Login");

        try {
            mySQLConnector = new MySQLConnector();
            whichPanel = getTypeUser();
            mySQLConnector.prepareEverything(whichPanel);
        } catch (Exception e) {
            e.printStackTrace();
        }

        try {
            md = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        initialize();

    }
    private void initialize() {
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


    private String getTypeUser() {
        Object[] possibilities = {"student", "teacher", "admin"};
        return (String) JOptionPane.showInputDialog(
                null,
                "Who are you:\n",
                "",
                JOptionPane.PLAIN_MESSAGE,
                null,
                possibilities,
                "2");
    }

    /**
     * sends given username and hashed password to DB. If correct recieves back id of student
     * and starts Frame
     */
    private void whenLoginButtonClicked() {

        String givenUserName = userText.getText();
        String givenPassword = passwordText.getText();

        String hashPassword = getHash(givenPassword);

        if (whichPanel.equals("admin")) {
            try {
                File file = new File("src/main/resources/admin.txt");

                FileReader fileReader = new FileReader(file);
                BufferedReader bufferedReader = new BufferedReader(fileReader);
                bufferedReader.readLine();
                String login = bufferedReader.readLine();
                String pass = bufferedReader.readLine();

                if (login.equals(givenUserName) && pass.equals(hashPassword)) {
                    this.setVisible(false);
                    frame = new Frame(this.mySQLConnector, 0, whichPanel);
                }

                fileReader.close();
                bufferedReader.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        String idString=null;
        if (whichPanel.equals("student")) {
            idString = mySQLConnector.loginStudent(givenUserName, hashPassword);
        } else if (whichPanel.equals("teacher")) {
            idString = mySQLConnector.loginTeacher(givenUserName, hashPassword);
        }
        //Sprawdzić czy się zgadza z bazą

        if (idString != null) {

            ID = Integer.parseInt(idString);
            this.setVisible(false);
            frame = new Frame(this.mySQLConnector, ID, whichPanel);

        } else if (givenUserName.equals("") || givenPassword.equals("")) {
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

