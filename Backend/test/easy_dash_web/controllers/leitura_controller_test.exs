defmodule EasyDashWeb.LeituraControllerTest do
  use EasyDashWeb.ConnCase

  import EasyDash.IotFixtures
  alias EasyDash.Iot.Leitura

  @create_attrs %{
    temperatura: 120.5,
    umidade: 120.5,
    sensor_id: "some sensor_id"
  }
  @update_attrs %{
    temperatura: 456.7,
    umidade: 456.7,
    sensor_id: "some updated sensor_id"
  }
  @invalid_attrs %{temperatura: nil, umidade: nil, sensor_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all leituras", %{conn: conn} do
      conn = get(conn, ~p"/api/leituras")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create leitura" do
    test "renders leitura when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/leituras", leitura: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/leituras/#{id}")

      assert %{
               "id" => ^id,
               "sensor_id" => "some sensor_id",
               "temperatura" => 120.5,
               "umidade" => 120.5
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/leituras", leitura: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update leitura" do
    setup [:create_leitura]

    test "renders leitura when data is valid", %{conn: conn, leitura: %Leitura{id: id} = leitura} do
      conn = put(conn, ~p"/api/leituras/#{leitura}", leitura: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/leituras/#{id}")

      assert %{
               "id" => ^id,
               "sensor_id" => "some updated sensor_id",
               "temperatura" => 456.7,
               "umidade" => 456.7
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, leitura: leitura} do
      conn = put(conn, ~p"/api/leituras/#{leitura}", leitura: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete leitura" do
    setup [:create_leitura]

    test "deletes chosen leitura", %{conn: conn, leitura: leitura} do
      conn = delete(conn, ~p"/api/leituras/#{leitura}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/leituras/#{leitura}")
      end
    end
  end

  defp create_leitura(_) do
    leitura = leitura_fixture()

    %{leitura: leitura}
  end
end
