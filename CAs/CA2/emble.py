# Define opcode, funct3, and funct7 mappings
opcode_map = {
    'add': '0110011', 'sub': '0110011', 'and': '0110011', 'or': '0110011', 'slt': '0110011',
    'addi': '0010011', 'xori': '0010011', 'ori': '0010011', 'slti': '0010011',
    'lw': '0000011', 'sw': '0100011', 'beq': '1100011', 'bne': '1100011',
    'jalr': '1100111', 'jal': '1101111', 'lui': '0110111'
}

funct3_map = {
    'add': '000', 'sub': '000', 'and': '111', 'or': '110', 'slt': '010',
    'addi': '000', 'xori': '100', 'ori': '110', 'slti': '010',
    'lw': '010', 'sw': '010', 'beq': '000', 'bne': '001', 'jalr': '000'
}

funct7_map = {
    'add': '0000000', 'sub': '0100000', 'and': '0000000', 'or': '0000000', 'slt': '0000000'
}


def reg_to_bin(reg):
    return f'{int(reg[1:]):05b}'

def assemble_r_type(inst, rd, rs1, rs2):
    funct7 = funct7_map[inst]
    funct3 = funct3_map[inst]
    opcode = opcode_map[inst]
    return f'{funct7}{reg_to_bin(rs2)}{reg_to_bin(rs1)}{funct3}{reg_to_bin(rd)}{opcode}'

def assemble_i_type(inst, rd, rs1, imm):
    imm_bin = f'{int(imm) & 0xFFF:012b}'
    funct3 = funct3_map[inst]
    opcode = opcode_map[inst]
    return f'{imm_bin}{reg_to_bin(rs1)}{funct3}{reg_to_bin(rd)}{opcode}'

def assemble_b_type(inst, rs1, rs2, offset):
    imm = int(offset)
    imm_bin = f'{(imm & 0x1000) >> 12}{(imm & 0x7E0) >> 5:06b}{(imm & 0x1E) >> 1:04b}{(imm & 0x800) >> 11}'
    funct3 = funct3_map[inst]
    opcode = opcode_map[inst]
    return f'{imm_bin[0]}{imm_bin[1:7]}{reg_to_bin(rs2)}{reg_to_bin(rs1)}{funct3}{imm_bin[7:]}{opcode}'

def assemble_jal(inst, rd, imm):
    imm = int(imm)
    imm_bin = f'{(imm & 0x80000) >> 20}{(imm & 0xFF000) >> 12:08b}{(imm & 0x800) >> 11}{(imm & 0x7FE) >> 1:10b}'
    opcode = opcode_map[inst]
    return f'{imm_bin}{reg_to_bin(rd)}{opcode}'

def parse_labels(lines):
    labels = {}
    line_no = 0
    for line in lines:
        line = line.split('#')[0].strip()  # Strip comments
        if ':' in line:
            label, instr = line.split(':')
            labels[label.strip()] = line_no
            if instr.strip():
                line_no += 1
        elif line:
            line_no += 1
    return labels

def replace_labels(lines, labels):
    for i, line in enumerate(lines):
        for label, address in labels.items():
            if label in line:
                offset = address - i - 1
                lines[i] = line.replace(label, str(offset))
    return lines

def assemble_instruction(line):
    parts = line.split()
    inst = parts[0]
    if inst in funct7_map:  # R-type
        rd, rs1, rs2 = parts[1].split(',')[0], parts[2], parts[3]
        return assemble_r_type(inst, rd, rs1, rs2)
    elif inst in opcode_map and inst != 'beq' and inst != 'bne':  # I-type
        rd, rs1, imm = parts[1].split(',')[0], parts[2], parts[3]
        return assemble_i_type(inst, rd, rs1, imm)
    elif inst in ['beq', 'bne']:  # B-type
        rs1, rs2, offset = parts[1].split(',')[0], parts[2], parts[3]
        return assemble_b_type(inst, rs1, rs2, offset)
    elif inst == 'jal':  # J-type
        rd, imm = parts[1].split(',')[0], parts[2]
        return assemble_jal(inst, rd, imm)
    return None

def process_file(input_file, output_file):
    with open(input_file, 'r') as infile:
        lines = infile.readlines()

    labels = parse_labels(lines)
    lines = replace_labels(lines, labels)

    with open(output_file, 'w') as outfile:
        for line in lines:
            line = line.split('#')[0].strip()  # Strip comments and whitespace
            if line and ':' not in line:
                instr = assemble_instruction(line)
                if instr:
                    hex_instr = f'{int(instr, 2):08x}'
                    outfile.write(f'{hex_instr}\\n')

# Run the script
process_file('C:\\Users\\Lenovo\\Desktop\\T5\\ComputerArchitecture\\computer-architecture\\CAs\\CA2\\HW2.s', 'output.hex')
