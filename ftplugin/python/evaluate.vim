python << EOL
import vim
def EvaluateCurrentRange():
	eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL
map <C-h> :py EvaluateCurrentRange()
