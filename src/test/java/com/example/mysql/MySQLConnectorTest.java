package com.example.mysql;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import javax.xml.bind.DatatypeConverter;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import static junit.framework.TestCase.assertEquals;
import static junit.framework.TestCase.assertNotNull;

public class MySQLConnectorTest {
    MySQLConnector mySQLConnector;

    @Before
    public void initialize() throws Exception {
        mySQLConnector = new MySQLConnector();
        mySQLConnector.prepareEverything("admin");
    }

    @Test
    public void loginStudentTest() {
        String userName = "nowak1";
        String hashPassword = "FB2FE71D592FAD516F05549409DA8E35";

        String result = mySQLConnector.loginStudent(userName, hashPassword);

        assertEquals("1", result);
    }

    @Test
    public void getHash() throws Exception{
        String password="walczakpw";

        MessageDigest md;
        md = MessageDigest.getInstance("MD5");

        md.update(password.getBytes());
        byte[] digest = md.digest();
        String hashedPassword = DatatypeConverter
                .printHexBinary(digest).toUpperCase();
        System.out.println(hashedPassword);
    }

    @After
    public void close() {
        mySQLConnector.close();
    }
}
