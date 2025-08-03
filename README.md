# 🔁 FSM Sequence Detector – Mealy vs Moore (Detecting "1011")

This project implements a **sequence detector for the binary pattern `1011`**, using both **Mealy** and **Moore** finite state machines. The focus is to understand their architectural differences in output behavior, state usage, and timing — all within a Verilog implementation.

---

## 🧠 Project Overview

The FSMs are designed to read a serial bitstream and assert the output high (`1`) for one clock cycle when the exact sequence `1011` is detected. The same logic is implemented using:

- **Mealy machine** – Output depends on current state **and** input
- **Moore machine** – Output depends only on current state

Both FSMs are written in Verilog, simulated, and visualized with waveforms to compare their behavior and structural differences.

---

## ⚙️ Design Differences

| Aspect | Mealy FSM | Moore FSM |
|--------|-----------|-----------|
| Output Control | Depends on state and input | Depends only on state |
| Number of States | 4 | 5 |
| Output Timing | Immediate (same clock cycle) | One clock cycle delayed |
| Design Simplicity | Slightly more compact | Slightly more predictable |

---

## 📊 Waveform Analysis

### 🔵 Mealy FSM

![Mealy Waveform](./images/mealy_waveform.png)

In the Mealy machine, the output `out = 1` is asserted during the **same cycle** when the final bit of the sequence (`1`) is received. This makes it slightly faster in terms of response, but it is also more sensitive to input transitions and prone to glitches if not timed carefully.

---

### 🟢 Moore FSM

![Moore Waveform](./images/moore_waveform.png)

In the Moore version, the output becomes `1` **after** the entire sequence has been received and the FSM transitions into a dedicated "output" state. This results in a **one-cycle delay**, but provides more reliable and stable output — especially useful in real hardware systems where output stability matters.

---

## 🧷 FSM State Diagram

## 🔁 FSM State Diagram

This section compares the Mealy and Moore Finite State Machines (FSMs) designed to detect the sequence `1011`.

### 📘 Mealy State Diagram
![Mealy FSM](https://github.com/VLSI-Shubh/Mealy-and-Moore-with-Identical-outputs/blob/2323711e27e40d0f7717e7e5fcd9f5972d52cdd1/images/mealy1011.png)

- **States used**: 4  
- **Output depends on**: Current state **and** input  
- **Advantage**: Fewer states required  
- **Drawback**: Output may glitch due to input changes

---

### 📗 Moore State Diagram
![Moore FSM](https://github.com/VLSI-Shubh/Mealy-and-Moore-with-Identical-outputs/blob/2323711e27e40d0f7717e7e5fcd9f5972d52cdd1/images/moore1011.png)

- **States used**: 5  
- **Output depends only on**: Current state  
- **Advantage**: More stable outputs  
- **Drawback**: Usually more states required

---

These diagrams clearly illustrate how both FSM models handle the same pattern detection logic using different architectural approaches.


---

## 📁 Project Files

| File | Description |
|------|-------------|
| `mealy_1011.v` | Verilog code for Mealy FSM |
| `moore_1011.v` | Verilog code for Moore FSM |
| `images/` | Waveforms and state diagram screenshots |
| `*.vcd` | Simulation output for waveform viewing |

---

## ✅ Conclusion

Through this project, I have explored the **practical trade-offs between Mealy and Moore FSMs** by implementing both styles for the same sequence detection logic.  

While the Mealy machine offers a more **compact design with faster output**, it comes with the risk of **glitchy behavior** due to input dependence in the output logic. The Moore machine, though it uses an extra state and introduces a **cycle delay**, produces more **stable and predictable outputs**, making it more suitable for hardware systems where timing and reliability are critical.

This exercise helped deepen my understanding of **state-based design**, **output timing control**, and how **FSM structure affects circuit behavior** — which is essential in digital design and VLSI systems.

---

## 📝 License

Open for educational and personal use under the MIT License.

