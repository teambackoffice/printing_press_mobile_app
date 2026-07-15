import 'package:flutter/material.dart';

class SalesJobWorksApp extends StatelessWidget {
  const SalesJobWorksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Job Works',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3854E0)),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          surfaceTintColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const JobWorksPage(),
    );
  }
}

// ----------------------------- MODELS -----------------------------

enum JobStatus { pending, inProgress, completed, onHold }

extension JobStatusX on JobStatus {
  String get label {
    switch (this) {
      case JobStatus.pending:
        return 'Pending';
      case JobStatus.inProgress:
        return 'In Progress';
      case JobStatus.completed:
        return 'Completed';
      case JobStatus.onHold:
        return 'On Hold';
    }
  }

  Color get color {
    switch (this) {
      case JobStatus.pending:
        return const Color(0xFFB07E00);
      case JobStatus.inProgress:
        return const Color(0xFF1565C0);
      case JobStatus.completed:
        return const Color(0xFF2E7D32);
      case JobStatus.onHold:
        return const Color(0xFFC62828);
    }
  }
}

enum JobPriority { low, medium, high }

extension JobPriorityX on JobPriority {
  String get label {
    switch (this) {
      case JobPriority.low:
        return 'Low';
      case JobPriority.medium:
        return 'Medium';
      case JobPriority.high:
        return 'High';
    }
  }

  Color get color {
    switch (this) {
      case JobPriority.high:
        return Colors.redAccent;
      case JobPriority.medium:
        return Colors.orangeAccent;
      case JobPriority.low:
        return Colors.green;
    }
  }
}

class Employee {
  final String id;
  final String name;
  final String role;
  final String initials;
  final int activeJobsCount;

  const Employee({
    required this.id,
    required this.name,
    required this.role,
    required this.initials,
    this.activeJobsCount = 0,
  });
}

class JobWork {
  final String id;
  final String title;
  final String customerName;
  final String orderRef;
  final double amount;
  final DateTime dueDate;
  final String description;
  JobStatus status;
  JobPriority priority;
  Employee? assignedEmployee;

  JobWork({
    required this.id,
    required this.title,
    required this.customerName,
    required this.orderRef,
    required this.amount,
    required this.dueDate,
    required this.description,
    this.status = JobStatus.pending,
    this.priority = JobPriority.medium,
    this.assignedEmployee,
  });
}

// ----------------------------- MOCK DATA -----------------------------

final List<Employee> mockEmployees = [
  const Employee(
    id: 'E1',
    name: 'Aditi Rao',
    role: 'Sales Executive',
    initials: 'AR',
    activeJobsCount: 3,
  ),
  const Employee(
    id: 'E2',
    name: 'Rahul Nair',
    role: 'Sales Executive',
    initials: 'RN',
    activeJobsCount: 1,
  ),
  const Employee(
    id: 'E3',
    name: 'Priya Menon',
    role: 'Field Officer',
    initials: 'PM',
    activeJobsCount: 5,
  ),
  const Employee(
    id: 'E4',
    name: 'Sanjay Kumar',
    role: 'Sales Executive',
    initials: 'SK',
    activeJobsCount: 2,
  ),
  const Employee(
    id: 'E5',
    name: 'Fathima Beevi',
    role: 'Field Officer',
    initials: 'FB',
    activeJobsCount: 0,
  ),
];

final List<JobWork> mockJobWorks = [
  JobWork(
    id: 'JW-1001',
    title: 'Site Survey & Quotation',
    customerName: 'Coral Textiles Pvt Ltd',
    orderRef: 'SO-2201',
    amount: 45000,
    dueDate: DateTime.now().add(const Duration(days: 2)),
    description:
        'Visit customer site to take measurements and prepare a detailed quotation for the requested installation.',
    status: JobStatus.pending,
    priority: JobPriority.high,
  ),
  JobWork(
    id: 'JW-1002',
    title: 'Product Demo',
    customerName: 'Greenfield Traders',
    orderRef: 'SO-2202',
    amount: 12500,
    dueDate: DateTime.now().add(const Duration(days: 5)),
    description:
        'Demonstrate new product line to the client procurement team at their office.',
    status: JobStatus.inProgress,
    priority: JobPriority.medium,
    assignedEmployee: mockEmployees[0],
  ),
  JobWork(
    id: 'JW-1003',
    title: 'Contract Renewal Follow-up',
    customerName: 'Blue Ocean Exports',
    orderRef: 'SO-2150',
    amount: 98000,
    dueDate: DateTime.now().subtract(const Duration(days: 1)),
    description:
        'Follow up with client regarding annual maintenance contract renewal and pending signatures.',
    status: JobStatus.onHold,
    priority: JobPriority.high,
    assignedEmployee: mockEmployees[2],
  ),
  JobWork(
    id: 'JW-1004',
    title: 'Delivery Coordination',
    customerName: 'Malabar Spices Co.',
    orderRef: 'SO-2210',
    amount: 30500,
    dueDate: DateTime.now().add(const Duration(days: 1)),
    description:
        'Coordinate with logistics for timely delivery and get delivery acknowledgement from customer.',
    status: JobStatus.completed,
    priority: JobPriority.low,
    assignedEmployee: mockEmployees[3],
  ),
  JobWork(
    id: 'JW-1005',
    title: 'New Lead Qualification',
    customerName: 'Sunrise Hardware',
    orderRef: 'SO-2215',
    amount: 8000,
    dueDate: DateTime.now().add(const Duration(days: 3)),
    description:
        'Call and qualify the inbound lead, gather requirements and budget expectations.',
    status: JobStatus.pending,
    priority: JobPriority.medium,
  ),
];

String _formatDate(DateTime date, {bool withYear = false}) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${date.day} ${months[date.month - 1]}${withYear ? ' ${date.year}' : ''}';
}

// ----------------------------- SINGLE PAGE -----------------------------

class JobWorksPage extends StatefulWidget {
  const JobWorksPage({super.key});

  @override
  State<JobWorksPage> createState() => _JobWorksPageState();
}

class _JobWorksPageState extends State<JobWorksPage> {
  final List<JobWork> _jobWorks = mockJobWorks;
  String _query = '';
  JobStatus? _filterStatus;

  // null = showing the list. Non-null = showing that job's detail, in place.
  JobWork? _selectedJob;

  List<JobWork> get _filtered {
    return _jobWorks.where((job) {
      final matchesQuery =
          _query.isEmpty ||
          job.title.toLowerCase().contains(_query.toLowerCase()) ||
          job.customerName.toLowerCase().contains(_query.toLowerCase()) ||
          job.id.toLowerCase().contains(_query.toLowerCase());
      final matchesStatus =
          _filterStatus == null || job.status == _filterStatus;
      return matchesQuery && matchesStatus;
    }).toList();
  }

  Future<void> _assignEmployee(JobWork job) async {
    final selected = await showModalBottomSheet<Employee>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AssignEmployeeSheet(current: job.assignedEmployee),
    );
    if (selected != null) {
      setState(() => job.assignedEmployee = selected);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Assigned to ${selected.name}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final job = _selectedJob;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        leading: job != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _selectedJob = null),
              )
            : null,
        title: Text(job != null ? job.id : 'Sales Job Works'),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: job == null
            ? _buildListView(key: const ValueKey('list'))
            : _buildDetailView(job, key: const ValueKey('detail')),
      ),
      bottomNavigationBar: job == null
          ? null
          : SafeArea(
              minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _assignEmployee(job),
                  icon: const Icon(Icons.person_add_alt_1),
                  label: Text(
                    job.assignedEmployee == null
                        ? 'Assign to Employee'
                        : 'Reassign Employee',
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // ---------- LIST VIEW ----------

  Widget _buildListView({Key? key}) {
    final jobs = _filtered;
    return Column(
      key: key,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search job, customer or ID...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _FilterChip(
                label: 'All',
                selected: _filterStatus == null,
                onTap: () => setState(() => _filterStatus = null),
              ),
              for (final status in JobStatus.values)
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _FilterChip(
                    label: status.label,
                    selected: _filterStatus == status,
                    onTap: () => setState(() => _filterStatus = status),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: jobs.isEmpty
              ? const Center(child: Text('No job works found'))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return _JobWorkCard(
                      job: job,
                      onTap: () => setState(() => _selectedJob = job),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ---------- DETAIL VIEW ----------

  Widget _buildDetailView(JobWork job, {Key? key}) {
    final overdue =
        job.dueDate.isBefore(DateTime.now()) &&
        job.status != JobStatus.completed;

    return SingleChildScrollView(
      key: key,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          job.title,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      _StatusChip(status: job.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    job.customerName,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  _PriorityDot(priority: job.priority),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Job Details',
            children: [
              _DetailRow(label: 'Order Ref.', value: job.orderRef),
              _DetailRow(
                label: 'Amount',
                value: '₹${job.amount.toStringAsFixed(0)}',
              ),
              _DetailRow(
                label: 'Due Date',
                value: _formatDate(job.dueDate, withYear: true),
                valueColor: overdue ? Colors.red : null,
              ),
              _DetailRow(label: 'Status', value: job.status.label),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Description',
            children: [
              Text(
                job.description,
                style: TextStyle(color: Colors.grey.shade800, height: 1.4),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _SectionCard(
            title: 'Assigned Employee',
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: job.assignedEmployee == null
                        ? Colors.grey.shade300
                        : Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.15),
                    child: Text(
                      job.assignedEmployee?.initials ?? '?',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: job.assignedEmployee == null
                            ? Colors.grey.shade600
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.assignedEmployee?.name ?? 'Not assigned yet',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: job.assignedEmployee == null
                                ? FontStyle.italic
                                : FontStyle.normal,
                            color: job.assignedEmployee == null
                                ? Colors.grey.shade600
                                : Colors.black87,
                          ),
                        ),
                        if (job.assignedEmployee != null)
                          Text(
                            job.assignedEmployee!.role,
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.grey.shade600,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}

// ----------------------------- SHARED WIDGETS -----------------------------

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      selectedColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final JobStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = status.color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _PriorityDot extends StatelessWidget {
  final JobPriority priority;
  const _PriorityDot({required this.priority});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: priority.color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '${priority.label} priority',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
        ),
      ],
    );
  }
}

class _JobWorkCard extends StatelessWidget {
  final JobWork job;
  final VoidCallback onTap;

  const _JobWorkCard({required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final overdue =
        job.dueDate.isBefore(DateTime.now()) &&
        job.status != JobStatus.completed;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  _StatusChip(status: job.status),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${job.id} • ${job.customerName}',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _PriorityDot(priority: job.priority),
                  const Spacer(),
                  Icon(
                    Icons.event,
                    size: 14,
                    color: overdue ? Colors.red : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(job.dueDate),
                    style: TextStyle(
                      fontSize: 12,
                      color: overdue ? Colors.red : Colors.grey.shade600,
                      fontWeight: overdue ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: job.assignedEmployee == null
                        ? Colors.grey.shade300
                        : Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.15),
                    child: Text(
                      job.assignedEmployee?.initials ?? '?',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: job.assignedEmployee == null
                            ? Colors.grey.shade600
                            : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    job.assignedEmployee?.name ?? 'Unassigned',
                    style: TextStyle(
                      fontSize: 12.5,
                      color: job.assignedEmployee == null
                          ? Colors.grey.shade500
                          : Colors.black87,
                      fontStyle: job.assignedEmployee == null
                          ? FontStyle.italic
                          : FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _DetailRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13.5),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: valueColor ?? Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssignEmployeeSheet extends StatefulWidget {
  final Employee? current;
  const _AssignEmployeeSheet({this.current});

  @override
  State<_AssignEmployeeSheet> createState() => _AssignEmployeeSheetState();
}

class _AssignEmployeeSheetState extends State<_AssignEmployeeSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final employees = mockEmployees
        .where((e) => e.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  children: [
                    const Text(
                      'Assign to employee',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search employee...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: const Color(0xFFF5F6FA),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  itemCount: employees.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    final isCurrent = widget.current?.id == employee.id;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.12),
                        child: Text(
                          employee.initials,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      title: Text(
                        employee.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${employee.role} • ${employee.activeJobsCount} active jobs',
                      ),
                      trailing: isCurrent
                          ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () => Navigator.pop(context, employee),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
