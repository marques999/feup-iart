package iart.application;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Frame;
import java.awt.event.ActionEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.ListSelectionModel;
import javax.swing.WindowConstants;

class GuiSelect extends JDialog {

    private final JList<String> guiList;

    GuiSelect(Frame parent, String[] valueList) {

        super(parent, true);

        final Dimension guiDimensions = new Dimension(360, 250);
        final JScrollPane guiScroll = new JScrollPane();
        final JPanel guiPanel = new JPanel();
        final JButton buttonOk = new JButton();
        final JButton buttonCancel = new JButton();

        guiList = new JList<>(valueList);
        guiList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        guiList.addMouseListener(new MouseAdapter() {
            public void mouseClicked(final MouseEvent evt) {
                guiListMouseClicked(evt);
            }
        });

        guiScroll.setViewportView(guiList);
        buttonOk.setText("OK");
        buttonOk.addActionListener(this::buttonOkActionPerformed);
        guiPanel.add(buttonOk);
        buttonCancel.setText("Cancelar");
        buttonCancel.addActionListener(this::buttonCancelActionPerformed);
        guiPanel.add(buttonCancel);
        setMinimumSize(guiDimensions);
        setPreferredSize(guiDimensions);
        setResizable(false);
        setTitle("Seleccione uma opção");
        setLocationRelativeTo(getParent());
        setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
        getContentPane().add(guiScroll, BorderLayout.CENTER);
        getContentPane().add(guiPanel, BorderLayout.PAGE_END);
    }

    private String dialogResult = null;

    final String getResult() {
        return dialogResult;
    }

    private void guiListMouseClicked(final MouseEvent evt) {

        final JList<?> list = (JList<?>) evt.getSource();

        if (evt.getClickCount() == 2) {

            final String selectedValue = (String) list.getSelectedValue();

            if (selectedValue != null) {
                dialogResult = selectedValue;
                dispose();
            }
        }
    }

    private void buttonCancelActionPerformed(final ActionEvent evt) {
        dispose();
    }

    private void buttonOkActionPerformed(final ActionEvent evt) {

        final String selectedValue = guiList.getSelectedValue();

        if (selectedValue == null) {
            JOptionPane.showMessageDialog(this, "Por favor seleccione uma opção primeiro!", "Bibliogenie", JOptionPane.WARNING_MESSAGE);
        }
        else {
            dialogResult = selectedValue;
            dispose();
        }
    }
}