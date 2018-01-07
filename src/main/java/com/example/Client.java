package com.example;

import com.example.mysql.MySQLConnector;
import com.example.view.LoginFrame;

public class Client {
    public static void main(String[] args) {
        try {
            MySQLConnector mySQLConnector = new MySQLConnector();
            new LoginFrame(mySQLConnector);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
