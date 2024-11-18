import 'package:balcony/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingHistoryPage extends StatefulWidget {
  @override
  _BookingHistoryPageState createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  int rowsPerPage = 10; // Initial rows per page
  int currentPage = 1; // Initial page number

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("booking in progress " ,"(active)"),
           20.verticalSpace,
            _buildBookingTable(isActive: true),
            20.verticalSpace,
            _buildSectionTitle("booking history","(inactive)"),
            20.verticalSpace,
            _buildBookingTable(isActive: false),
            const Spacer(),
            _buildPaginationControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title , String subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 28.spMin,
            fontWeight: FontWeight.w800,
            color: appColor.primaryColor,
          ),
        ),Text(
          subTitle,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 12.spMin,
            fontWeight: FontWeight.w400,
            color: appColor.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingTable({required bool isActive}) {
    // Example data (replace with dynamic data)
    final bookings = [
      {
        "workspace": "9 Homestead",
        "status": isActive ? "awaiting host to respond" : null,
        "date": isActive ? null : "01/24/2024",
      },
      {
        "workspace": "15 Garland",
        "status": isActive ? "accepted - 01/24/2024" : null,
        "date": isActive ? null : "01/20/2024",
      },
      {
        "workspace": "3432 Beachside",
        "status": isActive ? "accepted - 01/02/2024" : null,
        "date": isActive ? null : "01/18/2024",
      },
    ];

    return Container(
      decoration:BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey)
      ),
      child: Column(
        children: [
          _buildTableHeader(isActive),
          const Divider(height: 1, color: Colors.grey),
          ...bookings.map((booking) => _buildTableRow(booking, isActive)),
        ],
      ),
    );
  }

  Widget _buildTableHeader(bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
      child: Row(
        children: [
          const SizedBox(width: 24), // Space for the checkbox
          Expanded(
            child: Text(
              "Workspace",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 13.spMin,
                color: appColor.primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              isActive ? "Status / Date of Booking" : "More Info",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 13.spMin,
                color: appColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(Map<String, dynamic> booking, bool isActive) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6).r,
          child: Row(
            children: [
              const Checkbox(
                value: false,
                onChanged: null, // Replace with functionality
              ),
              Expanded(
                flex: 3,
                child: Text(
                  booking["workspace"],
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 13.spMin,
                    color: appColor.primaryColor,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: isActive
                    ? Text(
                  booking["status"] ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 13.spMin,
                  color: appColor.primaryColor,
                ),
                )
                    : const Icon(Icons.more_horiz, color: Colors.grey),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: Colors.grey)
      ],
    );
  }

  Widget _buildPaginationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DropdownButton<int>(
          value: rowsPerPage,
          items: [10, 20, 50]
              .map((rows) => DropdownMenuItem<int>(
            value: rows,
            child: Text("$rows rows per page"),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              rowsPerPage = value!;
            });
          },
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: currentPage > 1
                  ? () => setState(() => currentPage--)
                  : null,
            ),
            Text("Page $currentPage"),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: () => setState(() => currentPage++),
            ),
          ],
        ),
      ],
    );
  }
}
