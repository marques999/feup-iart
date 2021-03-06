package iart.application;

import iart.Bibliogenie;

import java.awt.BorderLayout;
import java.awt.Dimension;
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

import java.text.Normalizer;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;

import javax.swing.AbstractListModel;
import javax.swing.BorderFactory;
import javax.swing.DefaultListModel;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFileChooser;
import javax.swing.JLabel;
import javax.swing.JList;
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
import javax.swing.WindowConstants;
import javax.swing.event.ListSelectionEvent;
import javax.swing.filechooser.FileNameExtensionFilter;

import se.sics.jasper.ConversionFailedException;
import se.sics.jasper.IllegalTermException;
import se.sics.jasper.Query;
import se.sics.jasper.SICStus;
import se.sics.jasper.SPTerm;

public class GUIMain extends javax.swing.JFrame
{
    private final FileNameExtensionFilter textExtensionFilter = new FileNameExtensionFilter("Ficheiros de texto (*.txt)", "txt");
    private final DefaultListModel<String> defaultListModel = new DefaultListModel<>();

    public GUIMain()
    {
	final JToolBar guiToolbar = new JToolBar();
	final JButton buttonLoad = new JButton();
	final JButton buttonSave = new JButton();
	final JButton buttonExecute = new JButton();
	final JButton buttonClear = new JButton();
	final JButton buttonQuery = new JButton();
	final JButton buttonExit = new JButton();
	final JSplitPane guiSplit = new JSplitPane();
	final JPanel guiQuery = new JPanel();
	final JLabel labelQuery = new JLabel();
	final JScrollPane tabExamples = new JScrollPane();
	final JScrollPane tabHistory = new JScrollPane();
	final JScrollPane tabOutput = new JScrollPane();
	final JScrollPane tabInformation = new JScrollPane();
	final JTextPane textInformation = new JTextPane();
	GridBagConstraints gridBagConstraints;
	inputQuery = new JTextField();
	guiTabs = new JTabbedPane();
	listExamples = new JList<>();
	listHistory = new JList<>();
	textOutput = new JTextArea();
	setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
	setTitle(Bibliogenie.strProgramName);
	setIconImage(Toolkit.getDefaultToolkit().getImage(getClass().getResource("/iart/resources/application.png")));
	guiToolbar.setBorder(BorderFactory.createEmptyBorder(4, 4, 0, 4));
	guiToolbar.setFloatable(false);
	guiToolbar.setRollover(true);
	guiToolbar.setAlignmentY(0.5F);
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
	labelQuery.setText("Faça uma pergunta:");
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

	listExamples.setModel(new AbstractListModel<String>()
	{
	    private final String[] comandosExemplo =
	    {
		"Quem escreveu Os Maias?",
		"Quais são os livros mais conhecidos de Fernando Pessoa?",
		"Quem são os escritores africanos?",
		"E portugueses?",
		"Quais os escritores portugueses e espanhóis do século XV?",
		"Quantos livros de escritores africanos existem após o século XVI?",
		"E qual é o mais recente?",
		"Alberto Caeiro é heterónimo de Fernando Pessoa."
	    };
	    
	    @Override
	    public int getSize()
	    {
		return comandosExemplo.length;
	    }

	    @Override
	    public String getElementAt(int i)
	    {
		return comandosExemplo[i];
	    }
	});

	listExamples.addMouseListener(new MouseAdapter()
	{
	    @Override
	    public void mouseClicked(final MouseEvent evt)
	    {
		listExamplesMouseClicked(evt);
	    }
	});

	listExamples.addListSelectionListener(this::listExamplesValueChanged);
	listExamples.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
	tabExamples.setViewportView(listExamples);
	guiTabs.addTab("Exemplos", tabExamples);
	listHistory.setModel(defaultListModel);

	listHistory.addMouseListener(new MouseAdapter()
	{
	    @Override
	    public void mouseClicked(final MouseEvent evt)
	    {
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
        textInformation.setText("<html>\n<body>\n<h2 style=\"margin-top:0;text-align:center;\">/ Bibliogenie \\</h2>\n<b>Autores:</b>\n<br>\n<br>\n<p style=\"margin-top:0\">&nbsp;&nbsp;&nbsp;&nbsp;Diogo Marques (<a href=\"mailto:up201305642@fe.up.pt\">up201305642@fe.up.pt</a>)</p>\n<p style=\"margin-top:0\">&nbsp;&nbsp;&nbsp;&nbsp;Pedro Melo (<a href=\"mailto:up201305618@fe.up.pt\">up201305618@fe.up.pt</a>)</p>\n<br>\n<br>\n<b>Instruções:</b>\n<br>\n<ul style=\"margin-left:16px\">\n<li><b>Carregar: </b>carrega uma lista de perguntas de um ficheiro de texto</li>\n<li><b>Guardar: </b>guarda histórico de perguntas num ficheiro de texto</li>\n<li><b>Executar: </b>executa todas as perguntas existentes no histórico</li>\n<li><b>Limpar: </b>limpa todo o histórico das perguntas (se utilizador estiver na tab \"Histórico\"), limpa a consola de output (se utilizador estiver na tab \"Output\")</li>\n<li><b>Sair: </b>termina a execução deste programa</li>\n</ul>\n<br>\n<b>Descrição:</b>\n<br>\n<p style=\"margin: 0 0 12px; text-align: justify;\">O programa deve interpretar e responder a frases escritas em linguagem natural, usando DCGs. O programa deve incluir informação sobre escritores e respetivas obras literárias (pode incluir outra informação que considere relevante).</p>\n<p style=\"margin: 0 0 12px; text-align: justify;\">O programa deve respeitar os seguintes <span style=\"text-decoration: underline;\">requisitos</span>:</p>\n<ul style=\"margin-left:16px\">\n<li>Aceitação de frases afirmativas;</li>\n<li>Aceitação de frases interrogativas;</li>\n<li>Verificação da sintaxe da frase;</li>\n<li>Verificação da semântica da frase;</li>\n<li>Inclusão de um ou mais comandos. A inclusãso de mais que um comando numa mesma frase é traduzida pelo uso da partícula \"e\" nessa frase;</li>\n<li>Aceitação de frases iniciadas pela partícula \"e\", devendo ser guardado o contexto da frase anterior para resposta a esta frase;</li>\n<li>Uso de adjetivos e complementos (proposicionais, de modo, ...)</span></li>\n</ul>\n</body>\n</html>");
	textInformation.setHighlighter(null);
	textInformation.setKeymap(null);
	tabInformation.setViewportView(textInformation);
	guiTabs.addTab("Informações", tabInformation);
	guiSplit.setBottomComponent(guiTabs);
	getContentPane().add(guiSplit, BorderLayout.CENTER);
	setSize(new Dimension(450, 340));
	setLocationRelativeTo(null);
    }

    private final int EXAMPLES_TAB = 0;
    private final int HISTORY_TAB = 1;
    private final int OUTPUT_TAB = 2;

    private void buttonQueryActionPerformed(final ActionEvent evt)
    {
	search(inputQuery.getText());
    }

    private void search(final String queryMessage)
    {
	if (queryMessage == null || queryMessage.isEmpty())
	{
	    Bibliogenie.showWarning(this, "Por favor escreva uma pergunta antes de iniciar a pesquisa!");
	}
	else
	{
	    inputQuery.setText(queryMessage);
	    listHistory.clearSelection();
	    listExamples.clearSelection();

	    if (defaultListModel.contains(queryMessage))
	    {
		defaultListModel.removeElement(queryMessage);
	    }

	    defaultListModel.addElement(queryMessage);
	    guiTabs.setSelectedIndex(OUTPUT_TAB);
	    query(queryMessage);
	}
    }

    private void listHistoryMouseClicked(final MouseEvent evt)
    {
	searchList(evt);
    }

    private final String msgFormat = "\nQ: %s\nA: %s\n";
    
    public final PrologResponse parseResponse(final String userRequest) throws InterruptedException, Exception
    {
	final HashMap queryResults = new HashMap();
	final ArrayList<String> queryResult = new ArrayList<>();
	final SICStus sp = SICStus.getInitializedSICStus();
	final String generatedRequest = generateRequest(userRequest);
	final Query query = sp.openPrologQuery(generatedRequest, queryResults);

	PrologResponse myResponse = null;
	String functorName = null;
	
	try
	{
	    if (query.nextSolution())
	    {
		SPTerm spTerm = (SPTerm) queryResults.get("Lista");

		if (spTerm != null && spTerm.isList())
		{
		    SPTerm spTerm1 = new SPTerm(sp);
		    spTerm.getList(spTerm1, spTerm);
		    functorName = spTerm1.getFunctorName();

		    while (spTerm1.isValid())
		    {
			queryResult.add(spTerm1.toString());
			spTerm.getList(spTerm1, spTerm);
		    }
		}
		else
		{
		    if (spTerm != null && spTerm.isAtomic())
		    {
			myResponse = new SimpleResponse(userRequest, spTerm.toString());
		    }
		}
	    }
	    else
	    {
		myResponse = new SimpleResponse(userRequest, "False");
	    }
	}
	catch (final IllegalTermException | ConversionFailedException ex)
	{
	}
	finally
	{
	    query.close();
	}
	
	if (functorName == null)
	{
	    return myResponse;
	}
	
	if (functorName.equals("autor"))
	{
	    myResponse = new AutorResponse(userRequest, queryResult);
	}
	
	if (functorName.equals("livro"))
	{
	    myResponse = new LivroResponse(userRequest, queryResult);
	}

	return myResponse;
    }

    private void query(final String queryMessage)
    {
	try
	{
	    final PrologResponse prologResponse = parseResponse(queryMessage);
	    
	    if (prologResponse == null)
	    {
		textOutput.append(String.format(msgFormat, queryMessage, "Error"));
	    }
	    else
	    {
		prologResponse.writeOutput(textOutput);
		prologResponse.showDialog(this);
	    }
	    
	    guiTabs.setSelectedIndex(OUTPUT_TAB);
	}
	catch (final Exception ex)
	{
	    Bibliogenie.showError(this, ex);
	}
    }

    private void searchList(final MouseEvent evt)
    {
	final JList<?> list = (JList<?>) evt.getSource();

	if (evt.getClickCount() == 2)
	{
	    final String selectedValue = (String) list.getSelectedValue();

	    if (selectedValue != null)
	    {
		search(selectedValue);
	    }
	}
    }

    private void buttonLoadActionPerformed(final ActionEvent evt)
    {
	final JFileChooser fileChooser = new JFileChooser();

	fileChooser.setFileFilter(textExtensionFilter);

	if (fileChooser.showOpenDialog(this) != JFileChooser.APPROVE_OPTION)
	{
	    return;
	}

	try (BufferedReader br = new BufferedReader(new FileReader(fileChooser.getSelectedFile())))
	{
	    defaultListModel.clear();
	    guiTabs.setSelectedIndex(HISTORY_TAB);

	    for (String line; (line = br.readLine()) != null;)
	    {
		defaultListModel.addElement(line);
	    }
	}
	catch (IOException ex)
	{
	    Bibliogenie.showError(this, ex.getLocalizedMessage());
	}
    }

    private void buttonSaveActionPerformed(final ActionEvent evt)
    {
	final JFileChooser fileChooser = new JFileChooser();

	fileChooser.setFileFilter(textExtensionFilter);

	if (fileChooser.showSaveDialog(this) != JFileChooser.APPROVE_OPTION)
	{
	    return;
	}

	File buffer = new File(fileChooser.getSelectedFile() + ".txt");

	try (final BufferedWriter oout = new BufferedWriter(new FileWriter(buffer)))
	{
	    for (int i = 0; i < defaultListModel.getSize(); i++)
	    {
		oout.write(defaultListModel.elementAt(i));

		if (i < defaultListModel.getSize() - 1)
		{
		    oout.newLine();
		}
	    }
	}
	catch (IOException ex)
	{
	    Bibliogenie.showError(this, ex.getLocalizedMessage());
	}
    }

    private void buttonClearActionPerformed(final ActionEvent evt)
    {
	inputQuery.setText("");

	switch (guiTabs.getSelectedIndex())
	{
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

    private void buttonExecuteActionPerformed(final ActionEvent evt)
    {
	if (defaultListModel.isEmpty())
	{
	    Bibliogenie.showWarning(this, "Não adicionou nenhuma pesquisa ao histórico!");
	}
	else
	{
	    final Enumeration<String> s = defaultListModel.elements();

	    while (s.hasMoreElements())
	    {
		query(s.nextElement());
	    }

	    guiTabs.setSelectedIndex(OUTPUT_TAB);
	}
    }

    private void buttonExitActionPerformed(final ActionEvent evt)
    {
	System.exit(0);
    }

    private void listExamplesMouseClicked(final MouseEvent evt)
    {
	searchList(evt);
    }

    private void listExamplesValueChanged(final ListSelectionEvent evt)
    {
	inputQuery.setText(listExamples.getSelectedValue());
    }

    private void listHistoryValueChanged(final ListSelectionEvent evt)
    {
	inputQuery.setText(listHistory.getSelectedValue());
    }
    
    public static String generateRequest(String originalString)
    {
	boolean questionForm = originalString.endsWith("?");

	originalString = Normalizer.normalize(originalString, Normalizer.Form.NFD);
	originalString = originalString.replaceAll("[\\p{InCombiningDiacriticalMarks}]", "");

	final String[] words = originalString.split("\\s+");
	final StringBuilder sb = new StringBuilder();

	sb.append("query(Lista, [");

	for (int i = 0; i < words.length; i++)
	{
	    final String currentWord = words[i].replaceAll("[^\\w]", "");
	    char firstCharacter = currentWord.charAt(0);

	    if (Character.isUpperCase(firstCharacter))
	    {
		sb.append("'").append(currentWord).append("'");
	    }
	    else
	    {
		sb.append(currentWord);
	    }

	    if (i < words.length - 1)
	    {
		sb.append(", ");
	    }
	}

	if (questionForm)
	{
	    sb.append(", '?'");
	}

	sb.append("],[]).");

	return sb.toString();
    }

    private static String capitalCase(final String originalString)
    {
	char firstCharacter = originalString.charAt(0);

	if (Character.isUpperCase(firstCharacter))
	{
	    return originalString.charAt(0) + originalString.substring(1).toLowerCase();
	}

	return originalString.toLowerCase();
    }

    private JList<String> listExamples;
    private JList<String> listHistory;
    private JTabbedPane guiTabs;
    private JTextArea textOutput;
    private JTextField inputQuery;
}