{
    // This should exist in settings.json
    // This file can be accessed through the command palette -> Preferences: Open Settings (JSON)
    "editor.minimap.enabled": false,
    "editor.fontSize": 12,
    "editor.renderWhitespace": "selection",
    "editor.rulers": [
        80
    ],

    "terminal.integrated.fontSize": 12,
    "terminal.integrated.shell.osx": "/bin/zsh",
    "terminal.integrated.fontFamily": "Roboto Mono for Powerline",
    
    "telemetry.enableTelemetry": false,

    "files.autoSave": "onFocusChange",
    "workbench.editor.enablePreview": false,
    "workbench.iconTheme": "material-icon-theme",
    "workbench.colorTheme": "Monokai",
    "window.zoomLevel": 0,
    
    // ---------------
    // Golang settings
    // ---------------
    // Requires the vscode golang plugin to be installed
    "go.lintTool": "golangci-lint",
    "go.lintFlags": [
        "--fast"
    ],
    "go.useLanguageServer": true,
    "go.languageServerExperimentalFeatures": {
        "format": true,
        "diagnostics": true,
        "documentLink": true
    },
    "[go]": {
        "editor.codeActionsOnSave": {
            "editor.formatOnSave": false,
            "source.organizeImports": true,
        }
    },
    // VSCode will think this is uneeded but leave it per this:
    // https://github.com/golang/tools/blob/master/gopls/doc/vscode.md
    "gopls": {
        "completeUnimported": true, // autocomplete unimported packages
        "deepCompletion": true,     // enable deep completion
    },
    
    "go.formatTool": "goimports",
    
    "vs-kubernetes": {
        "vs-kubernetes.minikube-path": "$HOME/.vs-kubernetes/tools/minikube/darwin-amd64/minikube"
    },
    
    "[typescript]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    },
}
