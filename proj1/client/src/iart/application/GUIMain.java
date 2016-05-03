package iart.application;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Enumeration;

import javax.swing.AbstractListModel;
import javax.swing.BorderFactory;
import javax.swing.DefaultListModel;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.JTextPane;
import javax.swing.JToolBar;
import javax.swing.ListSelectionModel;
import javax.swing.SwingConstants;
import javax.swing.UIManager;
import javax.swing.WindowConstants;
import javax.swing.event.ListSelectionEvent;
import javax.swing.filechooser.FileNameExtensionFilter;

public class GUIMain extends javax.swing.JFrame {

    private static final String programName = "Bibliogenie";
    private static final String stringConnect = "Ligar";
    private static final String msgFormat = "\nQ: %s\nA: %s\n";
    private static final String msgNotConnected = "Não se encontra conectado a nenhum servidor!";

    private final HTTPRequest httpServer = new HTTPRequest();
    private final FileNameExtensionFilter textExtensionFilter = new FileNameExtensionFilter("Ficheiros de texto (*.txt)", "txt");
	private final ImageIcon iconConnect = new ImageIcon(getClass().getResource("/iart/resources/connect.png"));
	private final ImageIcon iconDisconnect = new ImageIcon(getClass().getResource("/iart/resources/disconnect.png"));
	private final DefaultListModel<String> defaultListModel = new DefaultListModel<>();

	private GUIMain() {
		initComponents();
	}

	private final int EXAMPLES_TAB = 0;
	private final int HISTORY_TAB = 1;
	private final int OUTPUT_TAB = 2;

	private void initComponents() {

		GridBagConstraints gridBagConstraints;

		final JToolBar guiToolbar = new JToolBar();
		final JButton buttonLoad = new JButton();
		final JButton buttonSave = new JButton();
		final JButton buttonExecute = new JButton();
		final JButton buttonClear = new JButton();
		final JButton buttonQuery = new JButton();
		final JButton buttonExit = new JButton();
		final JSplitPane guiSplit = new JSplitPane();
		final JPanel guiQuery = new javax.swing.JPanel();
		final JLabel labelQuery = new JLabel();
		final JScrollPane tabExamples = new JScrollPane();
		final JScrollPane tabHistory = new JScrollPane();
		final JScrollPane tabOutput = new JScrollPane();
		final JScrollPane tabInformation = new JScrollPane();
		final JTextPane textInformation = new JTextPane();

		buttonConnect = new JButton();
		inputQuery = new JTextField();
		guiTabs = new JTabbedPane();
		listExamples = new JList<>();
		listHistory = new JList<>();
		textOutput = new JTextArea();
		setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		setTitle(programName);
		setIconImage(Toolkit.getDefaultToolkit().getImage(getClass().getResource("/iart/resources/application.png")));
		guiToolbar.setBorder(BorderFactory.createEmptyBorder(4, 4, 0, 4));
		guiToolbar.setFloatable(false);
		guiToolbar.setRollover(true);
		guiToolbar.setAlignmentY(0.5F);
		buttonConnect.setIcon(iconConnect);
		buttonConnect.setText("Ligar");
		buttonConnect.setFocusable(false);
		buttonConnect.setHorizontalTextPosition(SwingConstants.RIGHT);
		buttonConnect.setVerticalTextPosition(SwingConstants.BOTTOM);
		buttonConnect.addActionListener(this::buttonConnectActionPerformed);
		buttonLoad.setIcon(new ImageIcon(getClass().getResource("/iart/resources/application_xp_terminal.png")));
		buttonLoad.setText("Carregar");
		buttonLoad.setFocusable(false);
		buttonLoad.setHorizontalTextPosition(SwingConstants.RIGHT);
		buttonLoad.setVerticalTextPosition(SwingConstants.BOTTOM);
		buttonLoad.addActionListener(this::buttonLoadActionPerformed);
		buttonSave.setIcon(new ImageIcon(getClass().getResource("/iart/resources/disk.png")));
		buttonSave.setText("Guardar");
		buttonSave.setFocusable(false);
		buttonSave.setHorizontalTextPosition(SwingConstants.RIGHT);
		buttonSave.setVerticalTextPosition(SwingConstants.BOTTOM);
		buttonSave.addActionListener(this::buttonSaveActionPerformed);
		buttonExecute.setIcon(new ImageIcon(getClass().getResource("/iart/resources/arrow_down.png")));
		buttonExecute.setText("Executar");
		buttonExecute.setFocusable(false);
		buttonExecute.setHorizontalTextPosition(SwingConstants.RIGHT);
		buttonExecute.setVerticalTextPosition(SwingConstants.BOTTOM);
		buttonExecute.addActionListener(this::buttonExecuteActionPerformed);
		buttonClear.setIcon(new ImageIcon(getClass().getResource("/iart/resources/delete.png")));
		buttonClear.setText("Limpar");
		buttonClear.setFocusable(false);
		buttonClear.setHorizontalTextPosition(SwingConstants.RIGHT);
		buttonClear.setVerticalTextPosition(SwingConstants.BOTTOM);
		buttonClear.addActionListener(this::buttonClearActionPerformed);
		buttonExit.setIcon(new ImageIcon(getClass().getResource("/iart/resources/door_in.png")));
		buttonExit.setText("Sair");
		buttonExit.setFocusable(false);
		buttonExit.setHorizontalTextPosition(SwingConstants.RIGHT);
		buttonExit.setVerticalTextPosition(SwingConstants.BOTTOM);
		buttonExit.addActionListener(this::buttonExitActionPerformed);
		guiToolbar.add(buttonConnect);
		guiToolbar.add(buttonLoad);
		guiToolbar.add(buttonSave);
		guiToolbar.add(buttonExecute);
		guiToolbar.add(buttonClear);
		guiToolbar.add(buttonExit);
		getContentPane().add(guiToolbar, BorderLayout.PAGE_START);
		guiSplit.setBorder(null);
		guiSplit.setDividerSize(0);
		guiSplit.setOrientation(JSplitPane.VERTICAL_SPLIT);
		guiQuery.setLayout(new GridBagLayout());
		labelQuery.setText("Fa�a uma pergunta:");
		gridBagConstraints = new GridBagConstraints();
		gridBagConstraints.gridx = 0;
		gridBagConstraints.gridy = 0;
		gridBagConstraints.fill = GridBagConstraints.VERTICAL;
		gridBagConstraints.insets = new Insets(8, 8, 8, 8);
		guiQuery.add(labelQuery, gridBagConstraints);
		inputQuery.setMinimumSize(new Dimension(80, 20));
		gridBagConstraints = new GridBagConstraints();
		gridBagConstraints.gridx = 1;
		gridBagConstraints.gridy = 0;
		gridBagConstraints.fill = GridBagConstraints.HORIZONTAL;
		gridBagConstraints.weightx = 1.0;
		gridBagConstraints.insets = new Insets(8, 0, 8, 0);
		guiQuery.add(inputQuery, gridBagConstraints);
		buttonQuery.setText("Pesquisar");
		buttonQuery.addActionListener(this::buttonQueryActionPerformed);
		gridBagConstraints = new GridBagConstraints();
		gridBagConstraints.gridx = 2;
		gridBagConstraints.gridy = 0;
		gridBagConstraints.fill = GridBagConstraints.BOTH;
		gridBagConstraints.insets = new Insets(8, 8, 8, 8);
		guiQuery.add(buttonQuery, gridBagConstraints);
		guiSplit.setLeftComponent(guiQuery);
		guiTabs.setBorder(BorderFactory.createEmptyBorder(0, 4, 4, 4));

		listExamples.setModel(new AbstractListModel<String>() {

			final String[] strings = {
				"Quem escreveu Os Maias?",
				"Quais são os livros mais conhecidos de Fernando Pessoa?",
				"Quem são os escritores africanos?",
				"E portugueses?",
				"Quais os escritores portugueses e espanhóis do século XV?",
				"Quantos livros de escritores africanos existem após o século XVI?",
				"E qual é o mais recente?",
				"Alberto Caeiro é heterónimo de Fernando Pessoa."
			};

			public int getSize() {
				return strings.length;
			}

			public String getElementAt(int i) {
				return strings[i];
			}
		});

		listExamples.addMouseListener(new MouseAdapter() {
			public void mouseClicked(final MouseEvent evt) {
				listExamplesMouseClicked(evt);
			}
		});

		listExamples.addListSelectionListener(this::listExamplesValueChanged);
		listExamples.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		tabExamples.setViewportView(listExamples);
		guiTabs.addTab("Exemplos", tabExamples);
		listHistory.setModel(defaultListModel);

		listHistory.addMouseListener(new MouseAdapter() {
			public void mouseClicked(final MouseEvent evt) {
				listHistoryMouseClicked(evt);
			}
		});

		listHistory.addListSelectionListener(this::listHistoryValueChanged);
		listHistory.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		tabHistory.setViewportView(listHistory);
		guiTabs.addTab("Histórico", tabHistory);
		textOutput.setEditable(false);
		textOutput.setColumns(40);
		textOutput.setFont(textOutput.getFont().deriveFont((float) 12));
		textOutput.setLineWrap(true);
		textOutput.setRows(8);
		textOutput.setTabSize(4);
		tabOutput.setViewportView(textOutput);
		guiTabs.addTab("Output", tabOutput);
		textInformation.setEditable(false);
		textInformation.setContentType("text/html");
		textInformation.setText("<html>\n  <head>\n\n<style>\nhtml, body {\nmargin:0;\npadding:0;\n}\n</style>\n  </head>\n  <body>\n      \n<h2 syle=\"margin-top:0;text-align:center;\">Bibliogenie!</h2>\n<b>Autores:</b>\n<p style=\"margin-top:0\">&nbsp;&nbsp;&nbsp;&nbsp;Diogo Marques (<a href=\"mailto:up201305642@fe.up.pt\">up201305642@fe.up.pt</a>)</p>\n\t<p style=\"margin-top:0\">&nbsp;&nbsp;&nbsp;&nbsp;Pedro Melo (up201305618.fe.up.pt)</p>\n<b style=\"margin-bottom:0\">Instru��es:</b>\n\t<ul style=\"margin-left:16px\">\n\t<li><b>Read:</b> carrega uma lista de perguntas de um ficheiro de texto</li>\n\t<li><b>Save: </b> guarda hist�rico de perguntas num ficheiro de texto</li>\n\t<li><b>Execute:</b> executa todas as perguntas existentes no hist�rico</li>\n\t<li><b>Clear:</b> limpa todo o hist�rico das perguntas (se o utilizador estiver na tab \"History\"), limpa a consola de output (se o utilizador estiver na tab \"Output\"</li>\n\t<li><b>Exit:</b>abandona este programa sem confirma��o</li>\n\t</ul>\n<b><i>Descri��o</i></b>\n<p style=\"margin: 0 0 12px; text-align: justify;\">\nO programa deve interpretar e responder a frases&nbsp;escritas em linguagem natural, <span style=\"font-weight: bold;\">usando DCGs</span>.&nbsp;</span><span lang=\"PT\">O programa deve incluir informa��o sobre </span>escritores e respetivas obras liter�rias<span lang=\"PT\"><span lang=\"pt\"></span> (pode\nincluir outra informa��o que considere relevante).\n</p>\n<p style=\"margin: 0pt 0cm 12px; text-align: justify;\">O programa deve respeitar os seguintes <span style=\"text-decoration: underline;\">requisitos</span>:</p>\n<ul style=\"margin-left:16px\">\n<li>Aceita��o de frases afirmativas</li>\n<li>Aceita��o de frases interrogativas</li>\n<li>Verifica��o da sintaxe da frase</li>\n<li>Verifica��o da sem�ntica da frase</li>\n<li>Inclus�o de um ou mais comandos. A inclus�o de mais que um comando numa mesma frase � traduzida pelo uso da part�cula \"e\" nessa frase</li>\n<li>Aceita��o de frases iniciadas pela part�cula \"e\", devendo ser guardado o contexto da frase anterior para resposta a esta frase</li>\n<li>Uso de adjetivos e complementos (proposicionais, de modo, ...)</span></li>\n</ul>\n</body>\n</html>");
		textInformation.setHighlighter(null);
		textInformation.setKeymap(null);
		tabInformation.setViewportView(textInformation);
		guiTabs.addTab("Informações", tabInformation);
		guiSplit.setBottomComponent(guiTabs);
		getContentPane().add(guiSplit, BorderLayout.CENTER);
		setSize(new Dimension(450, 340));
		setLocationRelativeTo(null);
	}

	private void buttonQueryActionPerformed(final ActionEvent evt) {
		search(inputQuery.getText());
	}

	private void search(final String queryMessage) {

		if (queryMessage == null || queryMessage.isEmpty()) {
			showWarning("Por favor escreva uma pergunta antes de iniciar a pesquisa.");
		}
		else {

			inputQuery.setText(queryMessage);

			if (httpServer.isConnected()) {

				listHistory.clearSelection();
				listExamples.clearSelection();

				if (defaultListModel.contains(queryMessage)) {
					defaultListModel.removeElement(queryMessage);
				}

				defaultListModel.addElement(queryMessage);
				guiTabs.setSelectedIndex(OUTPUT_TAB);
				query(queryMessage);
			}
			else {
				showError(msgNotConnected);
			}
		}
	}

	private void listHistoryMouseClicked(final MouseEvent evt) {
		searchList(evt);
	}

	private void query(final String queryMessage) {

		String serverResponse = httpServer.sendQuery(queryMessage);

		if (serverResponse == null) {
			serverResponse = httpServer.getError();
			textOutput.append(String.format(msgFormat, queryMessage, serverResponse));
			onDisconnect();
		}
		else {

			final int responseLength = serverResponse.length() - 1;

            if (serverResponse.matches("\\[(\"(.+?)\")(,\".+?\")*\\]")) {

				final String[] userOptions = serverResponse.trim().substring(1, responseLength).split(",\\ +");

				for (int i = 0; i < userOptions.length; i++) {
					userOptions[i] = userOptions[i].substring(1, userOptions[i].length() - 1);
				}

				final GUISelect guiSelect = new GUISelect(this, userOptions);

				guiSelect.setVisible(true);

				final String userChoice = guiSelect.getResult();

				if (userChoice == null) {
					textOutput.append(String.format(msgFormat, queryMessage, "cancelado pelo utilizador"));
				}
				else {
					query(userChoice);
				}
			}
			else {
				textOutput.append(String.format(msgFormat, queryMessage, serverResponse));
			}
		}
	}

	private void searchList(final MouseEvent evt) {

		final JList<?> list = (JList<?>) evt.getSource();

		if (evt.getClickCount() == 2) {

			final String selectedValue = (String) list.getSelectedValue();

			if (selectedValue != null) {
				search(selectedValue);
			}
		}
	}

	private void buttonLoadActionPerformed(final ActionEvent evt) {

		final JFileChooser fileChooser = new JFileChooser();

		fileChooser.setFileFilter(textExtensionFilter);

		if (fileChooser.showOpenDialog(this) != JFileChooser.APPROVE_OPTION) {
			return;
		}

		try (BufferedReader br = new BufferedReader(new FileReader(fileChooser.getSelectedFile()))) {

			defaultListModel.clear();
			guiTabs.setSelectedIndex(HISTORY_TAB);

			for (String line; (line = br.readLine()) != null;) {
				defaultListModel.addElement(line);
			}
		}
		catch (IOException ex) {
			showError(ex.getLocalizedMessage());
		}
	}

	private void buttonSaveActionPerformed(final ActionEvent evt) {

		final JFileChooser fileChooser = new JFileChooser();

		fileChooser.setFileFilter(textExtensionFilter);

		if (fileChooser.showSaveDialog(this) != JFileChooser.APPROVE_OPTION) {
			return;
		}

		File buffer = new File(fileChooser.getSelectedFile() + ".txt");

		try (final BufferedWriter oout = new BufferedWriter(new FileWriter(buffer))) {

			for (int i = 0; i < defaultListModel.getSize(); i++) {

				oout.write(defaultListModel.elementAt(i));

				if (i < defaultListModel.getSize() - 1) {
					oout.newLine();
				}
			}
		}
		catch (IOException ex) {
			showError(ex.getLocalizedMessage());
		}
	}

	private void showError(final String paramMessage) {
		JOptionPane.showMessageDialog(this, paramMessage, programName, JOptionPane.ERROR_MESSAGE);
	}

	private void showWarning(final String paramMessage) {
		JOptionPane.showMessageDialog(this, paramMessage, programName, JOptionPane.WARNING_MESSAGE);
	}

	private void buttonClearActionPerformed(final ActionEvent evt) {

		inputQuery.setText("");

		switch (guiTabs.getSelectedIndex()) {
		case HISTORY_TAB:
			defaultListModel.clear();
			break;
		case OUTPUT_TAB:
			textOutput.setText("");
			break;
		case EXAMPLES_TAB:
			listExamples.clearSelection();
			break;
		}
	}

	private void buttonExecuteActionPerformed(final ActionEvent evt) {

		if (httpServer.isConnected()) {

			if (defaultListModel.isEmpty()) {
                showWarning("Não adicionou nenhuma pesquisa ao histórico.");
			}
			else {

				final Enumeration<String> s = defaultListModel.elements();

				while (s.hasMoreElements()) {
					query(s.nextElement());
				}

				guiTabs.setSelectedIndex(OUTPUT_TAB);
			}
		}
		else {
			showError(msgNotConnected);
		}
	}

	private void buttonExitActionPerformed(final ActionEvent evt) {
		System.exit(0);
	}

	private void listExamplesMouseClicked(final MouseEvent evt) {
		searchList(evt);
	}

	private void listExamplesValueChanged(final ListSelectionEvent evt) {
		inputQuery.setText(listExamples.getSelectedValue());
	}

	private void listHistoryValueChanged(final ListSelectionEvent evt) {
		inputQuery.setText(listHistory.getSelectedValue());
	}

	protected void connect(final String paramAddress, int paramPort) {

		if (httpServer.connect(paramAddress, paramPort)) {
			buttonConnect.setText("Desligar");
			buttonConnect.setIcon(iconDisconnect);
		}
		else {
			showError(httpServer.getError());
		}
	}

	private void onDisconnect() {

		if (httpServer.getError() != null) {
			showError(httpServer.getError());
		}

		httpServer.disconnect(null);
		buttonConnect.setText(stringConnect);
		buttonConnect.setIcon(iconConnect);
	}

	private void buttonConnectActionPerformed(ActionEvent evt) {

		if (httpServer.isConnected()) {
			onDisconnect();
		}
		else {
			new GUIConnect(this, true).setVisible(true);
		}
	}

	public static void main(String args[]) {

        ResponseParser.getInstance().parseLivroResponse("[livro(cacb-mis1,'Mistérios de Lisboa - I',cacb,1854,romance,cacb-misl),livro(cacb-mis2,'Mistérios de Lisboa - II',cacb,1854,romance,cacb-misl),livro(cacb-mis3,'Mistérios de Lisboa - III',cacb,1854,romance,cacb-misl)]");

        try {
			UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
		}
		catch (Exception ex) {
			JOptionPane.showMessageDialog(null, ex.getLocalizedMessage(), programName, JOptionPane.ERROR_MESSAGE);
		}

		EventQueue.invokeLater(() -> new GUIMain().setVisible(true));
	}

	private JButton buttonConnect;
	private JList<String> listExamples;
	private JList<String> listHistory;
	private JTabbedPane guiTabs;
	private JTextArea textOutput;
	private JTextField inputQuery;
}