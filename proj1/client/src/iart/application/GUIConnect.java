package iart.application;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Frame;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;

import javax.swing.*;

public class GUIConnect extends JDialog {

    public GUIConnect(Frame parent, boolean modal) {

        super(parent, modal);

        GridBagConstraints gridBagConstraints;

        final ButtonGroup buttonGroup1 = new ButtonGroup();
        final Dimension guiDimensions = new Dimension(290, 140);
        final FlowLayout flowLayout1 = new FlowLayout();
        final JPanel guiGrid = new JPanel();
        final JLabel jLabel1 = new JLabel();
        final JLabel jLabel2 = new JLabel();
        final JPanel guiFlow = new JPanel();
        final JButton jButton1 = new JButton();
        final JButton jButton2 = new JButton();

        jTextField1 = new JTextField();
        jTextField2 = new JTextField();
        guiGrid.setBorder(BorderFactory.createEmptyBorder(8, 8, 8, 8));
        guiGrid.setLayout(new GridBagLayout());
        jLabel1.setFont(new Font("Tahoma", Font.BOLD, 11));
        jLabel1.setText("Endereço");
        gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.anchor = GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new Insets(8, 0, 8, 0);
        guiGrid.add(jLabel1, gridBagConstraints);
        jLabel2.setFont(new Font("Tahoma", Font.BOLD, 11));
        jLabel2.setText("Porta");
        gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.anchor = GridBagConstraints.LINE_START;
        gridBagConstraints.insets = new Insets(8, 3, 8, 3);
        guiGrid.add(jLabel2, gridBagConstraints);
        jTextField1.setColumns(20);
        jTextField1.setText("127.0.0.1");
        gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.gridx = 0;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.insets = new Insets(0, 0, 0, 8);
        guiGrid.add(jTextField1, gridBagConstraints);
        jTextField2.setColumns(6);
        jTextField2.setText("8080");
        gridBagConstraints = new GridBagConstraints();
        gridBagConstraints.gridx = 1;
        gridBagConstraints.gridy = 1;
        gridBagConstraints.fill = GridBagConstraints.HORIZONTAL;
        guiGrid.add(jTextField2, gridBagConstraints);
        flowLayout1.setAlignOnBaseline(true);
        guiFlow.setLayout(flowLayout1);
        jButton1.setText("Ligar");
        buttonGroup1.add(jButton1);
        jButton1.addActionListener(this::jButton1ActionPerformed);
        guiFlow.add(jButton1);
        jButton2.setText("Cancelar");
        buttonGroup1.add(jButton2);
        jButton2.addActionListener(this::jButton2ActionPerformed);
        guiFlow.add(jButton2);
        setTitle("Ligar");
        setResizable(false);
        setMinimumSize(guiDimensions);
        setPreferredSize(guiDimensions);
        setLocationRelativeTo(getParent());
        setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        getContentPane().add(guiGrid, BorderLayout.PAGE_START);
        getContentPane().add(guiFlow, BorderLayout.CENTER);
    }

    private void jButton2ActionPerformed(final ActionEvent evt) {
        dispose();
    }

    private void jButton1ActionPerformed(final ActionEvent evt) {
        ((GUIMain) getParent()).connect(jTextField1.getText(), Integer.parseInt(jTextField2.getText()));
        dispose();
    }

    private final JTextField jTextField1;
    private final JTextField jTextField2;
}