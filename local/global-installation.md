### 1. Storing the Script

- Save the script to a file named create-react-component.sh.
- Store this in a directory in your home folder, such as ~/scripts/.

```
mkdir ~/scripts
```

### 2. Making the Script Executable

Navigate to where you saved the script and make it executable:

```
chmod +x ~/scripts/create-react-component.sh
```

### 3. Adding Script Path to `$PATH` Variable

Add the script's directory to your `$PATH` so you can run the script from anywhere. Edit your `.bashrc` or `.zshrc` file:

```
nano ~/.bashrc  # or nano ~/.zshrc for zsh users
```

Add the following line at the end:

```
export PATH="$HOME/scripts:$PATH"
```

Then, apply the changes:

```
source ~/.bashrc  # or source ~/.zshrc for zsh users
```

### 4. Running the Script

You should now be able to run the script from anywhere:

```
create-react-component.sh ComponentName
```

### 5. Optional: Create an Alias for Shorter Command

For a shorter command, create an alias. Add this line to your `.bashrc` or `.zshrc`:

```
alias crc="create-react-component.sh"
```

After sourcing your rc file:

```
source ~/.bashrc  # or source ~/.zshrc for zsh users
```

You can now use:

```
crc ComponentName
```
