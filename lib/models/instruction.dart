class Instruction{
  final String instruction;
  final int instructionOrder;

  Instruction(this.instruction,this.instructionOrder);

  Map<String, dynamic> toJson() {
    return {
      'instruction': instruction,
      'order': instructionOrder,
    };
  }

  factory Instruction.fromJson(Map<String, dynamic> json) {

    return Instruction(
      json['instruction'] as String,
      json['order'] as int,
    );
  }

}