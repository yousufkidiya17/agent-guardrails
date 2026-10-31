<div align="center">

# 🛡️ Agent Guardrails & Claude Persona

**Enterprise-grade execution guardrails, anti-AI-slop filters, pedagogical notebook structures, and runtime safety hooks for Google Antigravity & AI Agent IDEs.**

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-007acc?style=for-the-badge&logo=opensourceinitiative&logoColor=white" alt="License: MIT"></a>
  <a href="#"><img src="https://img.shields.io/badge/Platform-Antigravity%20%7C%20Gemini%20%7C%20Claude-4f46e5?style=for-the-badge&logo=google&logoColor=white" alt="Platform"></a>
  <a href="#"><img src="https://img.shields.io/badge/Persona-Claude%203.5%20Sonnet%20Rigor-d97706?style=for-the-badge&logo=anthropic&logoColor=white" alt="Persona"></a>
  <a href="#"><img src="https://img.shields.io/badge/Guardrails-18%20Active%20Gates-10b981?style=for-the-badge&logo=shield&logoColor=white" alt="18 Gates"></a>
  <a href="#"><img src="https://img.shields.io/badge/OS-Windows%20%7C%20Linux%20%7C%20macOS-0284c7?style=for-the-badge&logo=windows&logoColor=white" alt="Cross-Platform"></a>
</p>

<p align="center">
  <b>Stop speculative execution loops • Enforce transparent pre/post actions • Eradicate AI sycophancy & slop</b>
</p>

---

### 🏷️ GitHub Topics & Tags
`antigravity-ide` • `claude-sonnet` • `ai-guardrails` • `agentic-coding` • `developer-tools` • `prompt-engineering` • `llm-safety` • `anti-slop` • `cursor-rules` • `gemini-cli` • `pair-programming`

</div>

---

## ⚡ The Problem vs. The Solution

| Default Agent Behavior ❌ | With Agent Guardrails ✅ |
| :--- | :--- |
| Runs multiple exploratory bash commands blindly in a loop. | **Max 1 command per turn** with mandatory pause and inspection. |
| Guesses consecutive shell variants when a command errors out. | **Immediate Stop on Failure**; halts and consults user. |
| Scans entire drives or GitHub accounts recursively without notice. | **Prohibition of Broad Scans**; strictly bounded targets. |
| Reads files silently or dumps entire 500-line files into chat. | **Mandatory Post-Read Findings** (1-2 crisp bullet points only). |
| Opens replies with hollow praise (*"Sure! Great question!"*). | **Zero Throat-Clearing**; opens directly with core technical insight. |
| Overuses clichéd AI slop (*"delve", "tapestry", "dive deep"*). | **Strict Anti-AI-Slop** vocabulary blocklist enforced. |
| Bunches all theory at top and code at bottom in notebooks. | **Granular Operation Pairing** (1 Markdown explanation cell above each Code cell). |

---

## 🏗️ System Architecture & Execution Flow

```mermaid
flowchart TD
    User([User Prompt / Task]) --> Core[Antigravity IDE Agent Core]
    
    subgraph DiscoveryLayer [Rule Discovery & Scoping]
        Global["Global Config (~/.gemini/config/AGENTS.md)"]
        Workspace["Project Workspace (<root>/AGENTS.md)"]
        Global -.->|Machine-Wide Baseline| Core
        Workspace -->|Highest Precedence Override| Core
    end

    subgraph RuntimeGates [GateGuard Interception Layer (.gateguard.yml)]
        PreAct{"Pre-Action Declaration?"}
        ReadCheck{"Read-Before-Edit Verified?"}
        CmdLimit{"Single Command Limit?"}
    end

    Core --> PreAct
    PreAct -->|Concise Hinglish Statement| ReadCheck
    ReadCheck -->|Pass| CmdLimit
    CmdLimit -->|Execute 1 Cmd| Target[(Terminal / Filesystem)]
    
    Target --> PostAct[Post-Read Inspection Protocol]
    PostAct -->|1-2 Bullets Finding - No Dump| Output([Claude Sonnet High-Signal Output])
```

---

## 🛡️ The 18 Guardrails Deep-Dive

### 1. Terminal & Execution Bounds (6 Rules)
1. **Max 1 Command Per Turn:** Enforces atomic command execution; stops runaway exploratory scripts.
2. **Immediate Stop on Failure:** Zero-guessing policy. If an exit code is non-zero, the agent stops instantly.
3. **Prohibition of Broad Scans:** Prohibits recursive disk searches and unauthorized multi-repo API sweeps.
4. **Pre-Action Declaration:** Transparent 1-line Hinglish declaration before every command, edit, or inspection.
5. **Mandatory Post-Read Finding:** Enforces 1-2 bullet points summarizing verified file structure after inspection.
6. **Immediate Respect for Denials:** Instantly halts tool chaining if the user denies permission.

### 2. Claude Sonnet Reasoning & Anti-Slop (4 Rules)
7. **Zero Sycophancy / Zero Padding:** Hollow praise and conversational throat-clearing are strictly banned.
8. **Intellectual Honesty:** Unflinchingly highlights trade-offs, edge cases, and architectural constraints.
9. **Strict Anti-AI-Slop Filter:** 11 overused AI buzzwords blocked:
   * ❌ `delve` • `tapestry` • `beacon` • `game-changer` • `testament to`
   * ❌ `unlock the full potential` • `dive deep` • `it is important to note` • `in conclusion` • `furthermore` • `holistic`
10. **High Signal Formatting:** Clean Markdown hierarchy (H2/H3), targeted bolding, and high density.

### 3. Pedagogical Notebook Architecture (4 Rules)
11. **Curriculum Alignment:** Optimized for hands-on pair programming (Apna College Prime AI/ML standard).
12. **Modular Isolation:** Separate dedicated notebook per lecture (`notebooks/dayX/lec_Y.ipynb`).
13. **Strict Markdown-Code Pairing:** High-level overview at the top; exactly one Markdown explanation cell directly above its matching Code cell for every single operation.
14. **No Auto-Git Push:** Background commits or pushes after lectures are banned unless explicitly triggered.

### 4. GateGuard Runtime Hooks (4 Gates)
15. **`read_before_edit: true`:** System-level block preventing files from being modified without prior read verification.
16. **Fact Verification Gates:** Enforces verification before executing destructive or routine bash operations.
17. **Read-Only Bypass:** Whitelists read-only commands (`ls`, `cat`) for rapid, low-overhead inspection.
18. **Dependency Ignore Paths:** Excludes `.venv/**`, `node_modules/**`, and `.git/**` from noise.

---

## 🚀 Installation & Quick Start

### Windows (PowerShell)
Open PowerShell and run:

```powershell
# Clone the repository
git clone https://github.com/yousufkidiya17/agent-guardrails.git
cd agent-guardrails

# 1-Click Install to Global Configuration (Applies to all sessions & folders)
.\install.ps1

# Optional: Also install directly into your current active project
.\install.ps1 -WorkspacePath "D:\AiMl"
```

### Linux & macOS (Bash)
```bash
git clone https://github.com/yousufkidiya17/agent-guardrails.git
cd agent-guardrails

chmod +x install.sh
# Global install
./install.sh

# Global + Project install
./install.sh /path/to/your/project
```

---

## 🔍 Verification & Health Check

To verify that all 5 configuration files are in place and active on your machine, run this in PowerShell:

```powershell
$files = @(
    "$env:USERPROFILE\.gemini\config\AGENTS.md",
    "$env:USERPROFILE\.gemini\config\GEMINI.md",
    ".\AGENTS.md",
    ".\GEMINI.md",
    ".\.gateguard.yml"
)
$files | Select-Object @{N="File";E={$_}}, @{N="Status";E={if (Test-Path $_) {"Active (OK)"} else {"Missing"}}} | Format-Table -AutoSize
```

---

## 📁 Repository Structure

```text
agent-guardrails/
├── AGENTS.md          # 18-rule core specification & Claude persona
├── GEMINI.md          # Mirror configuration for multi-agent discovery
├── .gateguard.yml     # Runtime safety hooks (read-before-edit, evidence checks)
├── install.ps1        # Automated cross-platform Windows installer
├── install.sh         # Automated Unix/macOS installer
├── LICENSE            # MIT License
└── README.md          # Comprehensive documentation & architectural diagrams
```

---

## 🤝 Contributing

Contributions, feature requests, and rule improvements are welcome!
1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/NewGuardrail`)
3. Commit your Changes (`git commit -m 'Add NewGuardrail'`)
4. Push to the Branch (`git push origin feature/NewGuardrail`)
5. Open a Pull Request

---

## 📄 License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for more details.

**Maintained by [Mohd Yousuf (@yousufkidiya17)](https://github.com/yousufkidiya17)**
