1. Copy/paste or clone `create-react-component.sh` to your repo

2. Update the `BASE_PATH` in `create-react-component.sh` to match your directory structure. The path should be relative to the file.

3. Run `chmod +x create-react-component.sh` to make the script executable

4. Add to package.json scripts. Make sure the path aligns with where you've put the file. Call the command whatever you like.

```json
"scripts": {
  "create-react-component": "bash ./create-react-component.sh",
  "crc": "npm run create-react-component"
}
```

4. If following the example above, run with:

```javascript
npm run create-react-component ComponentName

// or...
npm run crc ComponentName
```
