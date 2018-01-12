package com.example.view;

import com.example.mysql.MySQLConnector;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;


public class PanelAdmin extends JPanel{
    private MySQLConnector mySQLConnector;

    JButton backupB;
    JButton restoreB;

    public PanelAdmin(MySQLConnector mySQLConnector) {
        this.mySQLConnector = mySQLConnector;

        setBackground(Color.DARK_GRAY);
        initialize();
    }
    private void initialize() {
        backupB = new JButton("backup");
        backupB.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                whenBackupB();
            }
        });
        restoreB = new JButton("restore");
        restoreB.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                whenRestorB();
            }
        });

        add(backupB, "North");
        add(restoreB, "Center");
    }

    private void whenRestorB() {

    }
    private void whenBackupB() {
        backupDataWithDatabase();
    }

    public boolean backupDataWithDatabase() {
        boolean status = false;
        try {
            Process p = null;

            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            Date date = new Date();
            String filepath = "/home/sebastian/IdeaProjects/DanceBackup/" + "TEST" + ").sql";

            String batchCommand = "";

            //Backup with database
            batchCommand = "mysqldump -u admin_user -h localhost --password=adminpw DanceSchool > TEST.sql" ;

//          batchCommand = dumpExePath + " -h " + host + " --port " + port + " -u " + user + " --add-drop-database -B " + database + " -r \"" + backupPath + "" + filepath + "\"";


            Runtime runtime = Runtime.getRuntime();
//            p = runtime.exec(batchCommand);
            runtime.exec("mysqldump -u admin_user -h localhost --password=adminpw DanceSchool > TEST.sql");
//            int processComplete = runtime.waitFor();

//            if (processComplete == 0) {
//                status = true;
//                System.out.println("Backup created successfully for with DB ");
//            } else {
//                status = false;
//                System.out.println("Could not create the backup for with DB ");
//            }

        } catch (IOException ioe) {
            System.out.println(ioe);
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    private String getUserInput() {
        return JOptionPane.showInputDialog("Podaj haslo");
    }

}
