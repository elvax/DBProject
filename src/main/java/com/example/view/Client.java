package com.example.view;

import com.example.mysql.MySQLConnector;

import javax.swing.*;
import javax.xml.bind.DatatypeConverter;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Client {
    Frame frame;
    MySQLConnector mySQLConnector;
    int id;

    public Client() throws Exception{

        mySQLConnector = new MySQLConnector();
        mySQLConnector.prepareEverything();

        Login login = new Login();

//        frame = new Frame();
//        frame.setVisible(true);
    }

    public static void main(String[] args) throws Exception{
        Client test = new Client();

    }


    private class PanelStudent extends JPanel {

        JTextArea messageArea;
        JTextArea myClassesTextArea;
        JScrollPane scrollPane1;
        JScrollPane scrollPane2;
        JButton joinButton;
        JButton showMyClassesButton;
        JButton showAvilableClassesB;
        JLabel giveIdLabel;
        JLabel welcomeLabel;



        public PanelStudent() {
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


            myClassesTextArea = new JTextArea(20, 60);
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
            welcomeLabel.setText("Witaj " + mySQLConnector.getStudentName(Integer.toString(id)));

            showAvilableClassesB = new JButton("pokaz dostepne kursy");
            showAvilableClassesB.addActionListener(new ActionListener() {
                public void actionPerformed(ActionEvent actionEvent) {
                    whenshowAvilableClassesBClicked();
                }
            });

            messageArea = new JTextArea(20, 60);
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

                messageArea.setText("id name start end price prowadzacy miejsca\n");
                messageArea.append(mySQLConnector.writeAvailableCourses());

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        private void whenJoinButtonClicked() {
            mySQLConnector.joinStudent(getUserInput(), Integer.toString(id));
        }

        private void whenShowMyClassesButtonClicked() {
            myClassesTextArea.setText("id name start end price prowadzacy miejsca\n");
            myClassesTextArea.append(mySQLConnector.showStudentClasses(Integer.toString(id)));
        }

        private String getUserInput() {
            return JOptionPane.showInputDialog("Podaj id zajec");
        }
    }

    class Login extends JFrame {
        JButton loginButton;
        JPanel loginPanel;
        JTextField userText;
        JTextField passwordText;
        JLabel usernameLabel;
        JLabel passwordLabel;

        MessageDigest md;


        public Login(){

            super("Login Autentification");

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

            setSize(300,200);
            setLocation(500,280);
            loginPanel.setLayout (null);


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

        private void whenLoginButtonClicked() {

            String givenUserName = userText.getText();
            String givenPassword = passwordText.getText();

            String hashPassword = getHash(givenPassword);

            //Sprawdzić czy się zgadza z bazą
            String idString = mySQLConnector.loginStudent(givenUserName, hashPassword);
            if (idString != null) {
                id = Integer.parseInt(idString);
                this.setVisible(false);
                new Frame();
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

    class Frame extends JFrame {
        private final int X_SIZE = 700;
        private final int Y_SIZE = 750;

        public Frame() throws HeadlessException {
            setSize(X_SIZE, Y_SIZE);
            setTitle("School");
            setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            setResizable(true);
            setVisible(true);

            PanelStudent ps = new PanelStudent();
            add(ps);

        }

        private String getNumberOfPlayers() {
            Object[] possibilities = {"2", "3", "4", "6"};
            return (String) JOptionPane.showInputDialog(
                    null,
                    "Choose the number of players:\n",
                    "Number of players",
                    JOptionPane.PLAIN_MESSAGE,
                    null,
                    possibilities,
                    "2");
        }
    }
}
