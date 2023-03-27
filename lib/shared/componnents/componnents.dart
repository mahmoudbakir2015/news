import 'package:flutter/material.dart';
import 'package:news/shared/cubit/cubit.dart';

Widget buildItem({
  required BuildContext context,
  required dynamic article,
}) {
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20,
      top: 10,
    ),
    child: InkWell(
      onTap: () {
        AppCubitNews.launchURLApp(
          article['url'],
          inApp: true,
        );
      },
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(
                20,
              ),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget myDivider() {
  return Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20,
      top: 10,
    ),
    child: Container(
      height: 1,
      width: double.infinity,
      color: Colors.black45,
    ),
  );
}

Widget articleBuilder(
  list, {
  bool isSearch = false,
}) {
  return list.isNotEmpty
      ? ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          separatorBuilder: (BuildContext context, int index) => myDivider(),
          itemBuilder: (BuildContext context, int index) {
            return buildItem(
              article: list[index],
              context: context,
            );
          },
        )
      : Center(
          child: isSearch
              ? const Center(
                  child: Text("search to show result"),
                )
              : const CircularProgressIndicator(),
        );
}

Widget defaultTextForm({
  required String label,
  required TextEditingController controller,
  bool obscureText = false,
  required TextInputType textInputType,
  required IconData iconData,
  bool isSuffix = false,
  void Function(String)? onSubmitted,
  void Function(String)? onChange,
  required String? Function(String?)? onValidate,
  void Function()? onTap,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmitted,
      onChanged: onChange,
      validator: onValidate,
      controller: controller,
      obscureText: obscureText,
      keyboardType: textInputType,
      decoration: InputDecoration(
        prefixIcon: Icon(
          iconData,
        ),
        labelText: label,
        suffixIcon: isSuffix
            ? GestureDetector(
                onTap: onTap,
                child: obscureText
                    ? const Icon(
                        Icons.visibility_off,
                      )
                    : const Icon(
                        Icons.visibility,
                      ),
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );
void navigateTo({
  required BuildContext context,
  required Widget widget,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}
