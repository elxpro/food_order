defmodule ProductUploadConfig do
  import Phoenix.HTML

  def upload_options() do
    get_allow_options(Mix.env())
  end

  defp get_allow_options(env) when env in [:test, :prod] do
    [accept: ~w/.png .jpeg .jpg/, max_entries: 1]
  end

  defp get_allow_options(:dev) do
    [accept: ~w/.png .jpeg .jpg/, max_entries: 1, external: &generate_metadata/2]
  end

  def get_image_url(entry) do
    if Mix.env() in [:test, :prod] do
      "/uploads/#{filename(entry)}"
    else
      Path.join(s3_url(), filename(entry))
    end
  end

  def consume_entries(path, entry) do
    if Mix.env() in [:test, :prod] do
      file_name = filename(entry)
      dest = Path.join("priv/static/uploads", file_name)
      {:ok, File.cp!(path, dest)}
    else
      :ok
    end
  end

  @s3_bucket ""
  defp s3_url(), do: "//#{@s3_bucket}.s3.amazonaws.com"

  defp generate_metadata(entry, socket) do
    uploads = socket.assigns.uploads
    bucket = System.fetch_env!("AWS_BUCKET")
    key = filename(entry)

    config = %{
      region: System.fetch_env!("AWS_REGION"),
      access_key_id: System.fetch_env!("AWS_ACCESS_KEY_ID"),
      secret_access_key: System.fetch_env!("AWS_SECRET_ACCESS_KEY")
    }

    {:ok, fields} =
      SimpleS3Upload.sign_form_upload(config, bucket,
        key: key,
        content_type: entry.client_type,
        max_file_size: uploads[entry.upload_config].max_file_size,
        expires_in: :timer.hours(1)
      )

    metadata = %{
      uploaded: "S3",
      key: filename(entry),
      url: s3_url(),
      fields: fields
    }

    {:ok, metadata, socket}
  end

  defp filename(entry) do
    [ext | _] = MIME.extensions(entry.client_type)
    "#{entry.uuid}.#{ext}"
  end
end
