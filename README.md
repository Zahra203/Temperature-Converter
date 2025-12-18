




# 🌡️ Temperature Converter (8086 Assembly – MASM)

A simple **Temperature Converter** written in **8086 Assembly Language** using **MASM**, designed to run in a **DOS environment**. This project demonstrates basic arithmetic operations, input/output handling, and control flow in low-level programming.

---

## 🛠️ Requirements

Before running the program, make sure you have:

* **DOSBox** (or any DOS emulator)
* **MASM 8086 Assembler** (`8086_Assembler.zip`)
* Windows system (recommended for DOSBox)

---

## 📂 Setup Instructions

1. **Install DOSBox** on your system.
2. **Download and extract** `8086_Assembler.zip`.
3. Rename the extracted folder to **`asm`** (or any name you prefer).
4. Place the temperature converter source file (e.g., `temp.asm`) inside this folder.

---

## ▶️ How to Run the Program

Open **DOSBox** and execute the following commands step by step:

```text
mount c "path_to_your_asm_folder"
c:
masm.exe temp.asm
```

* Press **Enter three times** when prompted by MASM.

Then link the file:

```text
link temp
```

Once linking is complete, run the program:

```text
temp
```

---

## 📸 Output Screenshots

Below are sample screenshots showing the compilation and execution process in DOS:

<img width="645" height="363" alt="image" src="https://github.com/user-attachments/assets/1d2d6ab5-d7f4-404c-9437-9779dbadc97e" />
<img width="644" height="436" alt="image" src="https://github.com/user-attachments/assets/fe8fa870-c675-4fc7-8ae9-75478085b1ed" />
<img width="735" height="506" alt="image" src="https://github.com/user-attachments/assets/f04b5e25-bf6a-4304-8ddc-7a0c4d6040f5" />
<img width="747" height="513" alt="image" src="https://github.com/user-attachments/assets/b3875313-52a7-43f4-b529-3d8664520ea7" />


---

## ⚠️ Important Disclaimer

> **Do NOT type the letter `S` during execution.**
>
> The `S` visible in the screenshots appears automatically due to the screenshot capture process in DOSBox. It **does not affect the program output** and is **not part of the input**.

---

## 📚 Learning Purpose

This project is intended for:

* Beginners learning **8086 Assembly Language**
* Understanding **MASM syntax**
* Practicing **DOS-based program execution**
* Academic and educational use

---

