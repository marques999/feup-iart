package iart.application;

public class TextPane extends javax.swing.JDialog
{
    public TextPane(java.awt.Frame parent, boolean modal)
    {
	super(parent, modal);
	initComponents();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents()
    {

        jScrollPane2 = new javax.swing.JScrollPane();
        jEditorPane1 = new javax.swing.JEditorPane();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);

        jEditorPane1.setContentType("text/html"); // NOI18N
        jEditorPane1.setText("<html>\n<body>\n<h2 style=\"margin-top:0;text-align:center;\">Bibliogenie!</h2>\n<b>Autores:</b>\n<br>\n<br>\n<p style=\"margin-top:0\">&nbsp;&nbsp;&nbsp;&nbsp;Diogo Marques (<a href=\"mailto:up201305642@fe.up.pt\">up201305642@fe.up.pt</a>)</p>\n<p style=\"margin-top:0\">&nbsp;&nbsp;&nbsp;&nbsp;Pedro Melo (<a href=\"mailto:up201305618@fe.up.pt\">up201305618@fe.up.pt</a>)</p>\n<br>\n<b>Instruções:</b>\n<br>\n<ul style=\"margin-left:16px\">\n<li><b>Read:</b> carrega uma lista de perguntas de um ficheiro de texto</li>\n<li><b>Save: </b>&nbsp;guarda histórico de perguntas num ficheiro de texto</li>\n<li><b>Execute:</b> executa todas as perguntas existentes no hist?rico</li>\n<li><b>Clear:</b> limpa todo o hist?rico das perguntas (se utilizador estiver na tab \"History\"), limpa a consola de output (se utilizador estiver na tab \"Output\"</li>\n<li><b>Exit:</b>abandona este programa sem confirmação</li>\n</ul>\n<br>\n<b><i>Descrição</i></b>\n<br>\n<br>\n<p style=\"margin: 0 0 12px; text-align: justify;\">O programa deve interpretar e responder a frases escritas em linguagem natural, usando DCGs. O programa deve incluir informação sobre escritores e respetivas obras literárias (pode incluir outra informação que considere relevante).</p>\n<p style=\"margin: 0 0 12px; text-align: justify;\">O programa deve respeitar os seguintes <span style=\"text-decoration: underline;\">requisitos</span>:</p>\n<ul style=\"margin-left:16px\">\n<li>Aceitação de frases afirmativas;</li>\n<li>Aceitação de frases interrogativas;</li>\n<li>Verificação da sintaxe da frase;</li>\n<li>Verificação da semântica da frase;</li>\n<li>Inclusão de um ou mais comandos. A inclusãso de mais que um comando numa mesma frase é traduzida pelo uso da partícula \"e\" nessa frase;</li>\n<li>Aceitação de frases iniciadas pela partícula \"e\", devendo ser guardado o contexto da frase anterior para resposta a esta frase;</li>\n<li>Uso de adjetivos e complementos (proposicionais, de modo, ...)</span></li>\n</ul>\n</body>\n</html>");
        jScrollPane2.setViewportView(jEditorPane1);

        getContentPane().add(jScrollPane2, java.awt.BorderLayout.CENTER);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    public static void main(String args[])
    {
	java.awt.EventQueue.invokeLater(() ->
	{
	    TextPane dialog = new TextPane(new javax.swing.JFrame(), true);
	    dialog.addWindowListener(new java.awt.event.WindowAdapter()
	    {
		@Override
		public void windowClosing(java.awt.event.WindowEvent e)
		{
		    System.exit(0);
		}
	    });
	    dialog.setVisible(true);
	});
    }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JEditorPane jEditorPane1;
    private javax.swing.JScrollPane jScrollPane2;
    // End of variables declaration//GEN-END:variables
}